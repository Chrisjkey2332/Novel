<#
.SYNOPSIS
    Export the manuscript chapters of A Walk in the Valley of Shadows to .docx
    for a given edition.

.DESCRIPTION
    Builds an edition under editions/<Edition>/:
      * one chapter-XX.docx per manuscript chapter (always)
      * manuscript.docx  — single combined file with title page + TOC (with -Combined)
      * metadata.json     — snapshot of manuscript/metadata.json, stamped with this edition
      * manifest.md       — per-chapter word counts and total

    Book title/author/subtitle are read from manuscript/metadata.json and
    injected into the Word document properties and the combined title page.

.PARAMETER Edition
    Target edition tag (e.g. "1.3"). Output goes to editions/<Edition>/.

.PARAMETER ReferenceDoc
    Path to a .docx whose Word styles should be inherited. If omitted, the
    script prefers a stable, checked-in template at scripts/reference.docx,
    then falls back to the previous edition's chapter-01.docx, then to
    pandoc's default styling. Using a stable template avoids style drift that
    creeps in when each edition is built from the previous edition's output.

.PARAMETER Combined
    Also emit a single manuscript.docx (title page + table of contents).

.EXAMPLE
    ./export-edition.ps1 -Edition 1.4

.EXAMPLE
    ./export-edition.ps1 -Edition 1.4 -Combined

.NOTES
    Requires pandoc. Install: winget install JohnMacFarlane.Pandoc

    The manuscript .md files use single-newline paragraph separation, which
    CommonMark treats as soft line breaks. The script preprocesses each file
    to insert blank lines between paragraphs so pandoc emits proper paragraph
    breaks in Word.

    Standalone '*' lines (scene breaks) are converted to centered '* * *'
    paragraphs, and page breaks between chapters in the combined file are
    emitted, via a pandoc lua filter that produces raw OOXML.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Edition,

    [string]$ReferenceDoc,

    [switch]$Combined
)

$ErrorActionPreference = "Stop"

# Resolve project paths from this script's location.
$scriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$srcDir      = Join-Path $projectRoot "manuscript"
$dstDir      = Join-Path $projectRoot "editions/$Edition"
$metaPath    = Join-Path $srcDir "metadata.json"

# Refresh PATH from registry (winget installs may not be on the current session's PATH).
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' +
            [System.Environment]::GetEnvironmentVariable('Path','User')
$pandoc = (Get-Command pandoc -ErrorAction SilentlyContinue).Source
if (-not $pandoc) {
    throw "pandoc not found. Install: winget install JohnMacFarlane.Pandoc"
}

if (-not (Test-Path $srcDir)) { throw "Manuscript directory not found: $srcDir" }
if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Path $dstDir | Out-Null }

# --- Resolve the reference doc (stable template preferred) -------------------
if (-not $ReferenceDoc) {
    $stable = Join-Path $scriptDir "reference.docx"
    if (Test-Path $stable) {
        $ReferenceDoc = $stable
    } else {
        # Fall back to the highest-numbered *prior* edition's chapter-01.docx.
        $editionsDir = Join-Path $projectRoot "editions"
        $prior = Get-ChildItem $editionsDir -Directory -ErrorAction SilentlyContinue |
                 Where-Object { $_.Name -ne $Edition -and $_.Name -match '^\d+\.\d+$' } |
                 Sort-Object { [version]$_.Name } |
                 ForEach-Object { Join-Path $_.FullName "chapter-01.docx" } |
                 Where-Object { Test-Path $_ } |
                 Select-Object -Last 1
        if ($prior) { $ReferenceDoc = $prior }
    }
}
if ($ReferenceDoc -and -not (Test-Path $ReferenceDoc)) {
    throw "Reference doc not found: $ReferenceDoc"
}

# --- Read book metadata -----------------------------------------------------
$meta = $null
if (Test-Path $metaPath) { $meta = Get-Content $metaPath -Raw -Encoding utf8 | ConvertFrom-Json }
$bookTitle = if ($meta) { $meta.title }  else { "Manuscript" }
$author    = if ($meta) { $meta.author } else { "" }
$subtitle  = if ($meta) { $meta.subtitle } else { "" }

# --- Lua filter: scene breaks + page breaks ---------------------------------
$tmpDir = Join-Path $env:TEMP "novel-pandoc-build"
if (Test-Path $tmpDir) { Remove-Item -Recurse -Force $tmpDir }
New-Item -ItemType Directory -Path $tmpDir | Out-Null

$luaFilter = Join-Path $tmpDir "center-sections.lua"
@'
function Para(elem)
  local plaintext = pandoc.utils.stringify(elem)
  if plaintext == "* * *" then
    return pandoc.RawBlock("openxml", '<w:p><w:pPr><w:jc w:val="center"/></w:pPr><w:r><w:t xml:space="preserve">* * *</w:t></w:r></w:p>')
  end
  if plaintext == "[[PAGEBREAK]]" then
    return pandoc.RawBlock("openxml", '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
  end
end
'@ | Set-Content -Path $luaFilter -Encoding utf8 -NoNewline

# --- Preprocess a chapter's raw markdown into pandoc-ready CommonMark --------
function Convert-Chapter {
    param([string]$Raw)

    $lines = $Raw -split "`n"

    # Strip an optional inline plan block: drop everything from a '## Plan'
    # heading through a following '## Draft' heading, keeping the '# Chapter'
    # title above and the prose below. (No-op for prose-only chapters.)
    $planIdx  = -1; $draftIdx = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $t = $lines[$i].TrimEnd("`r").Trim()
        if ($planIdx  -lt 0 -and $t -match '^##\s+Plan\b')  { $planIdx  = $i }
        if ($t -match '^##\s+Draft\b') { $draftIdx = $i; break }
    }
    if ($planIdx -ge 0 -and $draftIdx -gt $planIdx) {
        $kept = @()
        if ($planIdx -gt 0) { $kept += $lines[0..($planIdx-1)] }
        if ($draftIdx -lt ($lines.Count-1)) { $kept += $lines[($draftIdx+1)..($lines.Count-1)] }
        $lines = $kept
    }

    $buf = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines) {
        $trimmed = $line.TrimEnd("`r")
        if ($trimmed -eq "*") {
            $buf.Add("\* \* \*")           # escaped so it survives to the lua filter as "* * *"
        } else {
            $buf.Add($trimmed)
        }
        if ($trimmed.Length -gt 0) { $buf.Add("") }
    }
    return ($buf -join "`n")
}

# --- Word count of prose (excludes markdown headings) -----------------------
function Measure-Prose {
    param([string]$Raw)
    $prose = ($Raw -split "`n") | Where-Object { $_.TrimStart() -notmatch '^#' }
    $text  = ($prose -join " ")
    $words = [regex]::Matches($text, '\b[\w'']+\b')
    return $words.Count
}

Write-Host "Pandoc:    $pandoc"
Write-Host ("Reference: {0}" -f ($(if ($ReferenceDoc) { $ReferenceDoc } else { "(pandoc default styling)" })))
Write-Host "Output:    $dstDir`n"

$refArgs = @()
if ($ReferenceDoc) { $refArgs = @("--reference-doc=$ReferenceDoc") }

$chapters = Get-ChildItem $srcDir -Filter "chapter-*.md" | Sort-Object Name

# --- Per-chapter build + word counts ----------------------------------------
$count = 0
$manifest = New-Object System.Collections.Generic.List[object]
$totalWords = 0
foreach ($ch in $chapters) {
    $raw       = Get-Content $ch.FullName -Raw -Encoding utf8
    $processed = Convert-Chapter -Raw $raw
    $words     = Measure-Prose -Raw $raw
    $totalWords += $words
    $manifest.Add([pscustomobject]@{ Chapter = $ch.BaseName; Words = $words })

    $tmpFile = Join-Path $tmpDir $ch.Name
    Set-Content -Path $tmpFile -Value $processed -Encoding utf8 -NoNewline

    $outDocx = Join-Path $dstDir ($ch.BaseName + ".docx")
    & $pandoc $tmpFile @refArgs "--lua-filter=$luaFilter" `
        "--metadata=title:$bookTitle" "--metadata=author:$author" -o $outDocx
    if ($LASTEXITCODE -ne 0) {
        Write-Host ("FAIL: {0}" -f $ch.Name) -ForegroundColor Red
    } else {
        Write-Host ("OK:   {0}" -f $ch.Name)
        $count++
    }
}

# --- Combined manuscript (title page + TOC) ---------------------------------
if ($Combined) {
    $parts = New-Object System.Collections.Generic.List[string]
    $first = $true
    foreach ($ch in $chapters) {
        if (-not $first) { $parts.Add("[[PAGEBREAK]]"); $parts.Add("") }
        $first = $false
        $parts.Add((Convert-Chapter -Raw (Get-Content $ch.FullName -Raw -Encoding utf8)))
    }
    $combinedMd = $parts -join "`n"
    $combinedFile = Join-Path $tmpDir "manuscript.md"
    Set-Content -Path $combinedFile -Value $combinedMd -Encoding utf8 -NoNewline

    $metaBlockLines = @("---", "title: `"$bookTitle`"")
    if ($subtitle) { $metaBlockLines += "subtitle: `"$subtitle`"" }
    if ($author)   { $metaBlockLines += "author: `"$author`"" }
    $metaBlockLines += "---"
    $metaBlock = ($metaBlockLines -join "`n")
    $metaFile  = Join-Path $tmpDir "meta.yaml"
    Set-Content -Path $metaFile -Value $metaBlock -Encoding utf8 -NoNewline

    $outCombined = Join-Path $dstDir "manuscript.docx"
    & $pandoc $metaFile $combinedFile @refArgs "--lua-filter=$luaFilter" `
        --toc --toc-depth=1 -o $outCombined
    if ($LASTEXITCODE -ne 0) {
        Write-Host "FAIL: manuscript.docx" -ForegroundColor Red
    } else {
        Write-Host "OK:   manuscript.docx (title page + TOC)"
    }
}

# --- Metadata snapshot ------------------------------------------------------
if ($meta) {
    $meta.currentEdition = $Edition
    ($meta | ConvertTo-Json -Depth 10) |
        Set-Content -Path (Join-Path $dstDir "metadata.json") -Encoding utf8
    Write-Host "OK:   metadata.json (snapshot, currentEdition=$Edition)"
}

# --- Manifest ---------------------------------------------------------------
$target = if ($meta -and $meta.targetWordsPerChapter) { [int]$meta.targetWordsPerChapter } else { 0 }
$manLines = New-Object System.Collections.Generic.List[string]
$manLines.Add("# Edition $Edition — Manifest")
$manLines.Add("")
$manLines.Add("Book: $bookTitle" + $(if ($author) { " — $author" } else { "" }))
$manLines.Add("Chapters: $($chapters.Count)  |  Total words: {0:N0}" -f $totalWords)
if ($chapters.Count -gt 0) { $manLines.Add("Average words/chapter: {0:N0}" -f ($totalWords / $chapters.Count)) }
if ($target -gt 0)         { $manLines.Add("Target words/chapter: {0:N0}" -f $target) }
$manLines.Add("")
$manLines.Add("| Chapter | Words |" + $(if ($target -gt 0) { " Δ vs target |" } else { "" }))
$manLines.Add("|---|---:|" + $(if ($target -gt 0) { "---:|" } else { "" }))
foreach ($row in $manifest) {
    $line = "| {0} | {1:N0} |" -f $row.Chapter, $row.Words
    if ($target -gt 0) { $line += (" {0:+#;-#;0} |" -f ($row.Words - $target)) }
    $manLines.Add($line)
}
($manLines -join "`n") | Set-Content -Path (Join-Path $dstDir "manifest.md") -Encoding utf8
Write-Host "OK:   manifest.md"

Remove-Item -Recurse -Force $tmpDir
Write-Host "`nExported $count chapter(s) to $dstDir"

<#
.SYNOPSIS
    Export the manuscript chapters of A Walk in the Valley of Shadows to .docx
    for a given edition.

.PARAMETER Edition
    Target edition tag (e.g. "1.2"). Output goes to editions/<Edition>/.

.PARAMETER ReferenceDoc
    Path to a .docx whose Word styles should be inherited. Defaults to
    editions/1.2/chapter-01.docx.

.EXAMPLE
    ./export-edition.ps1 -Edition 1.3

.EXAMPLE
    ./export-edition.ps1 -Edition 1.4 -ReferenceDoc editions/1.3/chapter-01.docx

.NOTES
    Requires pandoc. Install: winget install JohnMacFarlane.Pandoc

    The manuscript .md files use single-newline paragraph separation, which
    CommonMark treats as soft line breaks. The script preprocesses each file
    to insert blank lines between paragraphs so pandoc emits proper paragraph
    breaks in Word.

    Standalone '*' lines (scene breaks) are converted to centered '* * *'
    paragraphs via a pandoc lua filter that emits raw OOXML with center
    alignment.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Edition,

    [string]$ReferenceDoc
)

$ErrorActionPreference = "Stop"

# Resolve project paths from this script's location.
$scriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$srcDir      = Join-Path $projectRoot "manuscript"
$dstDir      = Join-Path $projectRoot "editions/$Edition"
if (-not $ReferenceDoc) {
    $ReferenceDoc = Join-Path $projectRoot "editions/1.2/chapter-01.docx"
}

# Refresh PATH from registry (winget installs may not be on the current session's PATH).
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' +
            [System.Environment]::GetEnvironmentVariable('Path','User')
$pandoc = (Get-Command pandoc -ErrorAction SilentlyContinue).Source
if (-not $pandoc) {
    throw "pandoc not found. Install: winget install JohnMacFarlane.Pandoc"
}

if (-not (Test-Path $srcDir))       { throw "Manuscript directory not found: $srcDir" }
if (-not (Test-Path $ReferenceDoc)) { throw "Reference doc not found: $ReferenceDoc" }
if (-not (Test-Path $dstDir))       { New-Item -ItemType Directory -Path $dstDir | Out-Null }

# Write the lua filter to a temp directory. The filter detects paragraphs whose
# plain text is "* * *" and replaces them with raw OOXML for a center-aligned
# paragraph.
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
end
'@ | Set-Content -Path $luaFilter -Encoding utf8 -NoNewline

Write-Host "Pandoc:    $pandoc"
Write-Host "Reference: $ReferenceDoc"
Write-Host "Output:    $dstDir`n"

$count = 0
Get-ChildItem $srcDir -Filter "chapter-*.md" | Sort-Object Name | ForEach-Object {
    # Preprocess: add a blank line after every non-empty line so that single-
    # newline separated paragraphs become CommonMark-compliant. Standalone '*'
    # lines are escaped to '\* \* \*' so they survive pandoc parsing as literal
    # characters and reach the lua filter as the string "* * *".
    $content = Get-Content $_.FullName -Raw -Encoding utf8
    $lines   = $content -split "`n"
    $buf     = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines) {
        $trimmed = $line.TrimEnd("`r")
        if ($trimmed -eq "*") {
            $buf.Add("\* \* \*")
        } else {
            $buf.Add($trimmed)
        }
        if ($trimmed.Length -gt 0) { $buf.Add("") }
    }
    $processed = $buf -join "`n"

    $tmpFile = Join-Path $tmpDir $_.Name
    Set-Content -Path $tmpFile -Value $processed -Encoding utf8 -NoNewline

    $outDocx = Join-Path $dstDir ($_.BaseName + ".docx")
    & $pandoc $tmpFile "--reference-doc=$ReferenceDoc" "--lua-filter=$luaFilter" -o $outDocx
    if ($LASTEXITCODE -ne 0) {
        Write-Host ("FAIL: {0}" -f $_.Name) -ForegroundColor Red
    } else {
        Write-Host ("OK:   {0}" -f $_.Name)
        $count++
    }
}

Remove-Item -Recurse -Force $tmpDir
Write-Host "`nExported $count chapter(s) to $dstDir"

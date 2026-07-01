<#
.SYNOPSIS
    Fast, deterministic QA pass over the manuscript. No pandoc required.

.DESCRIPTION
    Prints four mechanical checks that catch issues before a human review pass:

      1. Word counts       — per chapter vs metadata targetWordsPerChapter,
                             flagging chapters that are far off target.
      2. Author markers    — leftover [TODO ...], [TK], [[ ... ]], XXX in prose.
      3. Tense / POV leaks  — first-person *past-tense* narration outside dialogue
                             (the book is first-person present). Advisory: legitimate
                             flashbacks are rendered in past tense, so review, don't
                             blindly "fix".
      4. Character coverage — how often each character reference name appears in the
                             prose; a 0 count means an orphaned reference or a rename.

    These are heuristics meant to focus a human review, not replace it.

.PARAMETER Tolerance
    Fractional deviation from targetWordsPerChapter before a chapter is flagged.
    Default 0.4 (i.e. flag chapters <60% or >140% of target).

.PARAMETER TenseSamples
    Max example snippets to show per chapter for the tense/POV check. Default 3.

.EXAMPLE
    ./qa-report.ps1

.EXAMPLE
    ./qa-report.ps1 -Tolerance 0.25 -TenseSamples 5
#>
[CmdletBinding()]
param(
    [double]$Tolerance    = 0.4,
    [int]   $TenseSamples = 3
)

$ErrorActionPreference = "Stop"

$scriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$srcDir      = Join-Path $projectRoot "manuscript"
$charDir     = Join-Path $projectRoot "references/characters"
$metaPath    = Join-Path $srcDir "metadata.json"

if (-not (Test-Path $srcDir)) { throw "Manuscript directory not found: $srcDir" }

$meta   = if (Test-Path $metaPath) { Get-Content $metaPath -Raw -Encoding utf8 | ConvertFrom-Json } else { $null }
$target = if ($meta -and $meta.targetWordsPerChapter) { [int]$meta.targetWordsPerChapter } else { 0 }

$chapters = Get-ChildItem $srcDir -Filter "chapter-*.md" | Sort-Object Name

# Strip markdown heading lines; return prose text lines only.
function Get-ProseLines { param([string]$Raw) ($Raw -split "`n") | Where-Object { $_.TrimStart() -notmatch '^#' } }

# Remove quoted dialogue (curly and straight quotes) so narration can be checked alone.
function Remove-Dialogue {
    param([string]$Text)
    $t = [regex]::Replace($Text, '“[^”]*”', ' ')   # “ … ”
    $t = [regex]::Replace($t,    '"[^"]*"', ' ')                   # " … "
    return $t
}

Write-Host "===============================================================" -ForegroundColor Cyan
Write-Host " QA report — $(if ($meta) { $meta.title } else { 'manuscript' })"      -ForegroundColor Cyan
Write-Host "===============================================================" -ForegroundColor Cyan

# --- 1. Word counts ---------------------------------------------------------
Write-Host "`n[1] WORD COUNTS" -ForegroundColor Yellow
if ($target -gt 0) { Write-Host ("    target = {0:N0} words/chapter, tolerance +/-{1:P0}" -f $target, $Tolerance) }
$total = 0
foreach ($ch in $chapters) {
    $raw   = Get-Content $ch.FullName -Raw -Encoding utf8
    $prose = (Get-ProseLines -Raw $raw) -join " "
    $words = [regex]::Matches($prose, "\b[\w']+\b").Count
    $total += $words
    $flag = ""
    if ($target -gt 0) {
        if     ($words -lt $target * (1 - $Tolerance)) { $flag = "  << short" }
        elseif ($words -gt $target * (1 + $Tolerance)) { $flag = "  >> long" }
    }
    $color = if ($flag) { "Red" } else { "Gray" }
    Write-Host ("    {0,-12} {1,6:N0}{2}" -f $ch.BaseName, $words, $flag) -ForegroundColor $color
}
Write-Host ("    {0,-12} {1,6:N0}  total  ({2:N0} avg)" -f "ALL", $total, ($total / [Math]::Max(1,$chapters.Count))) -ForegroundColor Cyan

# --- 2. Author markers ------------------------------------------------------
Write-Host "`n[2] LEFTOVER AUTHOR MARKERS" -ForegroundColor Yellow
$markerRx = '(\[TODO|\[TK\b|\bTK\b|\bXXX\b|\[\[.*?\]\]|\bFIXME\b)'
$markerHits = 0
foreach ($ch in $chapters) {
    $n = 1
    foreach ($line in (Get-Content $ch.FullName -Encoding utf8)) {
        if ($line -match $markerRx) {
            Write-Host ("    {0}:{1}  {2}" -f $ch.BaseName, $n, $line.Trim()) -ForegroundColor Red
            $markerHits++
        }
        $n++
    }
}
if ($markerHits -eq 0) { Write-Host "    none" -ForegroundColor Green }

# --- 3. Tense / POV leaks ---------------------------------------------------
Write-Host "`n[3] FIRST-PERSON PAST-TENSE NARRATION (advisory)" -ForegroundColor Yellow
Write-Host "    Flashbacks are legitimately past tense — review, do not auto-fix." -ForegroundColor DarkGray
# "I" + irregular simple-past OR "I <verb>ed"; also we/my-narration past-tense "was/were/had".
$pastRx = "\bI\s+(?:was|were|had|did|said|saw|went|felt|knew|took|came|stood|sat|looked|walked|turned|watched|heard|thought|found|made|held|gave|told|asked|moved|realb?ized|realised|realized)\b|\bI\s+[a-z]{3,}ed\b"
$totalLeaks = 0
foreach ($ch in $chapters) {
    $narration = Remove-Dialogue -Text ((Get-ProseLines -Raw (Get-Content $ch.FullName -Raw -Encoding utf8)) -join "`n")
    $matches   = [regex]::Matches($narration, $pastRx, 'IgnoreCase')
    if ($matches.Count -gt 0) {
        $totalLeaks += $matches.Count
        Write-Host ("    {0}: {1} hit(s)" -f $ch.BaseName, $matches.Count) -ForegroundColor Red
        $shown = 0
        foreach ($m in $matches) {
            if ($shown -ge $TenseSamples) { break }
            $start = [Math]::Max(0, $m.Index - 25)
            $len   = [Math]::Min(70, $narration.Length - $start)
            $ctx   = ($narration.Substring($start, $len) -replace '\s+', ' ').Trim()
            Write-Host ("        ...{0}..." -f $ctx) -ForegroundColor DarkYellow
            $shown++
        }
    }
}
if ($totalLeaks -eq 0) { Write-Host "    none" -ForegroundColor Green }

# --- 4. Character reference coverage ----------------------------------------
Write-Host "`n[4] CHARACTER REFERENCE COVERAGE" -ForegroundColor Yellow
if (-not (Test-Path $charDir)) {
    Write-Host "    (no references/characters directory)" -ForegroundColor DarkGray
} else {
    $allProse = ($chapters | ForEach-Object { Get-Content $_.FullName -Raw -Encoding utf8 }) -join "`n"
    foreach ($cf in (Get-ChildItem $charDir -Filter *.json | Sort-Object Name)) {
        $c = Get-Content $cf.FullName -Raw -Encoding utf8 | ConvertFrom-Json
        $name = $c.name
        if (-not $name) { continue }
        $fullCount = [regex]::Matches($allProse, [regex]::Escape($name), 'IgnoreCase').Count
        # Also count meaningful capitalized name tokens (surname/given), skipping articles.
        $stop   = @('The','And','Of','A','An')
        $tokens = ($name -split '\s+') | Where-Object { $_ -cmatch '^[A-Z][a-z]{2,}$' -and $stop -notcontains $_ }
        $tokenInfo = ($tokens | ForEach-Object {
            $tc = [regex]::Matches($allProse, ('\b' + [regex]::Escape($_) + '\b')).Count
            "{0}={1}" -f $_, $tc
        }) -join ", "
        $color = if ($fullCount -eq 0 -and ($tokens.Count -eq 0)) { "Red" }
                 elseif ($fullCount -eq 0) { "DarkYellow" } else { "Gray" }
        $flag = if ($fullCount -eq 0 -and $tokens.Count -eq 0) { "  << ORPHAN (0 hits)" } else { "" }
        Write-Host ("    {0,-22} full='{1}':{2}   {3}{4}" -f $cf.BaseName, $name, $fullCount, $tokenInfo, $flag) -ForegroundColor $color
    }
}

Write-Host "`nDone." -ForegroundColor Cyan

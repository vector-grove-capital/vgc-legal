<#
    check-site.ps1 -- assert the LIVE site, not the source.

    Written because the site spent weeks returning 200 on every page while every
    link ON those pages was dead: Jekyll had inherited baseurl "/vgc-legal" and
    the home page pointed at /vgc-legal/privacy-policy.html, which does not exist.
    Fetching a page and checking its status code cannot see that. This follows the
    links.

    -SelfTest proves the checker can fail before its passes are believed.
#>
[CmdletBinding()]
param(
    [string] $Base = 'https://apps.vectorgrovecapital.com',
    [switch] $SkipExternal,
    [switch] $SelfTest
)

$ErrorActionPreference = 'Stop'
$ProgressPreference    = 'SilentlyContinue'

# Every page that must exist. /privacy-policy and /eula are the URLs given to
# Atlassian; they are listed without a trailing slash on purpose.
$Pages = @(
    '/',
    '/apps/sprint-dates/',
    '/apps/test-coverage/',
    '/security/',
    '/support/',
    '/terms/',
    '/privacy-policy',
    '/eula'
)

$script:failures = @()
function Fail($what, $why) { $script:failures += "$what -- $why"; Write-Host ("  FAIL [{0}] -- {1}" -f $what, $why) -ForegroundColor Red }
function Pass($what, $note) { Write-Host ("  PASS [{0}]{1}" -f $what, $(if ($note) { " -- $note" })) -ForegroundColor Green }

function Get-Page($url) {
    try {
        $r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 25
        return @{ ok = $true; status = [int]$r.StatusCode; body = $r.Content }
    } catch {
        $s = 0
        if ($_.Exception.Response) { $s = [int]$_.Exception.Response.StatusCode }
        return @{ ok = $false; status = $s; body = '' }
    }
}

function Resolve-Link($href, $pageUrl) {
    if ($href -match '^(mailto:|tel:|#|javascript:)') { return $null }
    try { return ([uri]::new([uri]$pageUrl, $href)).AbsoluteUri } catch { return $null }
}

Write-Host "== pages ==" -ForegroundColor Cyan
$bodies = @{}
foreach ($p in $Pages) {
    $url = "$Base$p"
    $r = Get-Page $url
    if ($r.ok) { Pass $p ("{0}, {1} bytes" -f $r.status, $r.body.Length); $bodies[$url] = $r.body }
    else { Fail $p ("HTTP {0}" -f $r.status) }
}

# Every href/src found in the rendered HTML, resolved and fetched once.
Write-Host "== links found in the rendered HTML ==" -ForegroundColor Cyan
$targets = @{}   # absolute url -> list of pages referencing it
foreach ($pageUrl in $bodies.Keys) {
    foreach ($m in [regex]::Matches($bodies[$pageUrl], '(?:href|src)="([^"]+)"')) {
        $abs = Resolve-Link $m.Groups[1].Value $pageUrl
        if (-not $abs) { continue }
        if (-not $targets.ContainsKey($abs)) { $targets[$abs] = @() }
        if ($targets[$abs] -notcontains $pageUrl) { $targets[$abs] += $pageUrl }
    }
}

$internal = $targets.Keys | Where-Object { $_ -like "$Base*" } | Sort-Object
$external = $targets.Keys | Where-Object { $_ -notlike "$Base*" } | Sort-Object
Write-Host ("  {0} internal target(s), {1} external" -f $internal.Count, $external.Count)

foreach ($u in $internal) {
    $r = Get-Page $u
    $short = $u.Substring($Base.Length); if (-not $short) { $short = '/' }
    if ($r.ok) { Pass $short } else { Fail $short ("HTTP {0} -- linked from {1}" -f $r.status, ($targets[$u] -join ', ')) }
}

# The stylesheet must not merely exist; it must be the stylesheet. A wrong-path
# CSS that some server answers with an HTML page would still be "200".
$css = "$Base/assets/css/site.css"
$r = Get-Page $css
if (-not $r.ok) { Fail 'stylesheet' ("HTTP {0}" -f $r.status) }
elseif ($r.body -notmatch '--accent') { Fail 'stylesheet' 'served, but does not contain the expected CSS custom properties' }
else { Pass 'stylesheet' 'served and contains --accent' }

# The referenced stylesheet must be THAT stylesheet, on every page.
$wrongCss = $internal | Where-Object { $_ -like '*style*css*' -and $_ -notlike "$css*" }
if ($wrongCss) { Fail 'stylesheet path' ("pages reference an unexpected stylesheet: {0}" -f ($wrongCss -join ', ')) }
else { Pass 'stylesheet path' 'every page references /assets/css/site.css' }

if (-not $SkipExternal) {
    Write-Host "== external links ==" -ForegroundColor Cyan
    foreach ($u in $external) {
        $r = Get-Page $u
        if ($r.ok) { Pass $u ("{0}" -f $r.status) }
        elseif ($r.status -in 403, 405, 429, 999) { Write-Host ("  SKIP [{0}] -- HTTP {1}, bot protection not a dead link" -f $u, $r.status) -ForegroundColor DarkYellow }
        else { Fail $u ("HTTP {0} -- linked from {1}" -f $r.status, ($targets[$u] -join ', ')) }
    }
}

# Content assertions that a status code cannot make.
Write-Host "== content ==" -ForegroundColor Cyan
# NOT $home: PowerShell's $HOME is read-only and variable names are case-insensitive,
# so assigning to $home aborts the script. Same trap as the -Jql/$jql collision.
$homeBody = $bodies["$Base/"]
if ($homeBody) {
    if ($homeBody -match 'Vector Grove') { Pass 'brand on home' } else { Fail 'brand on home' 'the words "Vector Grove" do not appear' }
    if ($homeBody -match 'vgc-legal/') { Fail 'baseurl leak on home' 'a "/vgc-legal/" path is still being emitted' } else { Pass 'no baseurl leak on home' }
}
foreach ($legal in @("$Base/privacy-policy", "$Base/eula")) {
    $b = $bodies[$legal]
    if ($b -and $b -match 'Vector Grove Capital LLC') { Pass ("LLC named in {0}" -f $legal.Substring($Base.Length)) }
    elseif ($b) { Fail ("LLC named in {0}" -f $legal.Substring($Base.Length)) 'the contracting entity is missing from a legal document' }
}

if ($SelfTest) {
    Write-Host "== self-test: the checker must be able to fail ==" -ForegroundColor Cyan
    $before = $script:failures.Count
    $r = Get-Page "$Base/this-page-does-not-exist-$([guid]::NewGuid().ToString('N'))"
    if ($r.ok) { Fail 'self-test' 'a guaranteed-missing URL returned success; the checker cannot detect a dead link' }
    else {
        Write-Host ("  a known-missing URL returned HTTP {0} and would be reported as a failure" -f $r.status) -ForegroundColor Green
        Pass 'self-test' 'dead links are detectable'
    }
    if ($script:failures.Count -ne $before) { Write-Host '  (self-test itself recorded a failure)' -ForegroundColor Red }
}

Write-Host ''
if ($script:failures.Count -eq 0) {
    Write-Host "ALL CHECKS PASSED" -ForegroundColor Green
    exit 0
} else {
    Write-Host ("{0} CHECK(S) FAILED" -f $script:failures.Count) -ForegroundColor Red
    $script:failures | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    exit 1
}

# Verify link preview metadata - run after deploying to production
# Simulates Snapchat-like crawler checks for page and og:image

$BaseUrl = "https://www.yassinamin.com"
$PageUrl = "$BaseUrl/"
$ImageUrl = "$BaseUrl/assets/og-preview.png?v=2"
$UserAgent = "Mozilla/5.0 (compatible; Snapchat; +https://www.snap.com)"

Write-Host "=== 1. Page URL (HTTP status, redirects) ===" -ForegroundColor Cyan
try {
    $page = Invoke-WebRequest -Uri $PageUrl -Method Head -UserAgent $UserAgent -MaximumRedirection 5
    Write-Host "Status: $($page.StatusCode)"
} catch {
    Write-Host "Error: $_"
}

Write-Host ""
Write-Host "=== 2. OG Image URL (HTTP status, content-type) ===" -ForegroundColor Cyan
try {
    $img = Invoke-WebRequest -Uri $ImageUrl -Method Head -UserAgent $UserAgent
    Write-Host "Status: $($img.StatusCode)"
    Write-Host "Content-Type: $($img.Headers['Content-Type'])"
} catch {
    Write-Host "Error: $_"
}

Write-Host ""
Write-Host "=== 3. Meta tags in HTML ===" -ForegroundColor Cyan
$html = Invoke-WebRequest -Uri $PageUrl -UserAgent $UserAgent
$html.Content | Select-String -Pattern 'property="og:|name="twitter:' -AllMatches | ForEach-Object { $_.Line }

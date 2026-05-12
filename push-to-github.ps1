# Yoga Tantra Trainer — first-time setup + push to GitHub
# Run from PowerShell in the project folder:
#   cd "C:\Users\ereze\OneDrive\Documents\Claude\Projects\tantra yoga trainer"
#   powershell -ExecutionPolicy Bypass -File push-to-github.ps1
#
# Requires git installed: https://git-scm.com/download/win
# You will be prompted to sign in to GitHub the first time.

$ErrorActionPreference = "Stop"

Write-Host "==> Step 1: Cleaning up old / scratch files" -ForegroundColor Cyan
if (Test-Path "index.html")     { Remove-Item "index.html" -Force }
if (Test-Path "index.new.html") { Rename-Item "index.new.html" "index.html" }
if (Test-Path ".write_test")    { Remove-Item ".write_test" -Force }

# An earlier session left a partial .git folder. Nuke it so we start clean.
if (Test-Path ".git") {
  $hasObjects = Test-Path ".git\objects"
  if (-not $hasObjects) {
    Write-Host "    (removing incomplete .git folder)" -ForegroundColor DarkYellow
    Remove-Item -Recurse -Force ".git"
  }
}

Write-Host "==> Step 2: Initializing git repo" -ForegroundColor Cyan
if (-not (Test-Path ".git")) { git init | Out-Null }
git config user.name  "Erez"
git config user.email "erezev@gmail.com"

@'
# Editor / OS junk
.DS_Store
Thumbs.db
*.swp

# Cowork scratch
.write_test
push-to-github.ps1
'@ | Out-File -FilePath ".gitignore" -Encoding utf8 -NoNewline

Write-Host "==> Step 3: Staging and committing" -ForegroundColor Cyan
git add -A
$staged = git diff --cached --name-only
if (-not $staged) {
  Write-Host "    (nothing to commit; skipping)" -ForegroundColor DarkYellow
} else {
  git commit -m "Tinder-style swipe deck for asana picker"
}

Write-Host "==> Step 4: Setting branch + remote" -ForegroundColor Cyan
git branch -M main
$remoteUrl = "https://github.com/erezev-debug/tantra-yoga.git"
$existing = $null
try { $existing = git remote get-url origin 2>$null } catch {}
if (-not $existing) {
  git remote add origin $remoteUrl
} elseif ($existing -ne $remoteUrl) {
  git remote set-url origin $remoteUrl
}

Write-Host "==> Step 5: Pushing to GitHub (sign-in prompt may appear)" -ForegroundColor Cyan
git push -u origin main

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host "If GitHub Pages is enabled on this repo (Settings > Pages > main / root)," -ForegroundColor Green
Write-Host "your app will be live at:" -ForegroundColor Green
Write-Host "  https://erezev-debug.github.io/tantra-yoga/" -ForegroundColor Yellow

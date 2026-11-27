# Start WhatsApp Contact Sync lokaal (backend + web) en opent de browser.
# Gebruik: rechtermuisklik > "Uitvoeren met PowerShell", of: powershell -ExecutionPolicy Bypass -File start.ps1

$root = $PSScriptRoot
$envFile = Join-Path $root "server\.env"

if (-not (Test-Path $envFile)) { Write-Host "server\.env ontbreekt. Zie SETUP-NL.md" -ForegroundColor Red; Read-Host "Enter om te sluiten"; exit 1 }

$envText = Get-Content $envFile -Raw
if ($envText -notmatch "GOOGLE_CLIENT_ID=\S+" -or $envText -notmatch "GOOGLE_CLIENT_SECRET=\S+") {
    Write-Host "Vul eerst GOOGLE_CLIENT_ID en GOOGLE_CLIENT_SECRET in server\.env in. Zie SETUP-NL.md" -ForegroundColor Red
    Read-Host "Enter om te sluiten"; exit 1
}

# Backend: laadt server\.env en draait op poort 8080
$backend = Start-Process powershell -PassThru -WorkingDirectory (Join-Path $root "server") -ArgumentList @(
    "-NoExit", "-Command",
    "`$host.UI.RawUI.WindowTitle='WhaSync backend'; Get-Content .env | Where-Object { `$_ -match '^\s*[^#].*=' } | ForEach-Object { `$k,`$v = `$_ -split '=',2; Set-Item -Path ('env:' + `$k.Trim()) -Value `$v.Trim() }; npx ts-node --transpile-only ."
)

# Web: draait op poort 4000 en stuurt /api door naar de backend
$web = Start-Process powershell -PassThru -WorkingDirectory (Join-Path $root "web") -ArgumentList @(
    "-NoExit", "-Command", "`$host.UI.RawUI.WindowTitle='WhaSync web'; npm run dev"
)

Write-Host "Bezig met opstarten..."
Start-Sleep -Seconds 8
Start-Process "http://localhost:4000"
Write-Host "Geopend: http://localhost:4000  (sluit de twee PowerShell-vensters om te stoppen)" -ForegroundColor Green

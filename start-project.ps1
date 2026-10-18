# Smart HMS - Start All Services
Write-Host "Starting Smart HMS Services..." -ForegroundColor Cyan

# Determine correct base directory whether run from root or Patient-Management-System-main
$baseDir = if (Test-Path "$PSScriptRoot\Patient-Management-System-main") { 
    "$PSScriptRoot\Patient-Management-System-main" 
} elseif (Test-Path "$PSScriptRoot\laravel-service") { 
    $PSScriptRoot 
} else { 
    "$PSScriptRoot\Patient-Management-System-main" 
}

# 1. Start Laravel Service (Port 8000)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$baseDir\laravel-service'; Write-Host 'Starting Laravel API on port 8000...' -ForegroundColor Green; php artisan serve --port=8000"

# 2. Start Express Service (Port 4001)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$baseDir\express-service'; Write-Host 'Starting Express API on port 4001...' -ForegroundColor Green; npm run dev"

# 3. Start Angular Client (Port 4200)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$baseDir\client'; Write-Host 'Starting Angular Client on port 4200...' -ForegroundColor Green; npm start"

Write-Host "All 3 services are launching in separate windows." -ForegroundColor Yellow
Write-Host "Frontend will be accessible at: http://localhost:4200" -ForegroundColor Cyan

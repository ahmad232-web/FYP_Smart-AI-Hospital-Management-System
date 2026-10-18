# Smart HMS - Stop All Services
Write-Host "Stopping all running services (PHP, Node/Express/Angular)..." -ForegroundColor Yellow

$ports = @(8000, 4001, 4200)

foreach ($port in $ports) {
    $connections = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($connections) {
        foreach ($conn in $connections) {
            $pidToKill = $conn.OwningProcess
            if ($pidToKill -gt 0) {
                Write-Host "Stopping process on port $port (PID: $pidToKill)..." -ForegroundColor Cyan
                Stop-Process -Id $pidToKill -Force -ErrorAction SilentlyContinue
            }
        }
    }
}

Write-Host "All project servers on ports 8000, 4001, and 4200 have been stopped." -ForegroundColor Green

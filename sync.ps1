# Manual sync script - Pull and Push without making new commits
# Use this to sync existing commits with remote repository

try {
    $currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    
    Write-Host "[$currentDate] Starting manual sync..." -ForegroundColor Cyan
    
    # Pull remote changes first
    Write-Host "[$currentDate] Pulling from remote..." -ForegroundColor Blue
    $pullResult = git pull origin main 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[$currentDate] Pull completed successfully" -ForegroundColor Green
    } else {
        Write-Host "[$currentDate] Pull result: $pullResult" -ForegroundColor Yellow
    }
    
    # Check if there are any local commits to push
    $ahead = git rev-list --count origin/main..HEAD 2>$null
    if ($ahead -and $ahead -gt 0) {
        Write-Host "[$currentDate] Found $ahead local commits to push..." -ForegroundColor Blue
        
        # Push local commits to remote
        $pushResult = git push origin main 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[$currentDate] Push completed successfully" -ForegroundColor Green
            Write-Host "[$currentDate] Sync complete! $ahead commits pushed." -ForegroundColor Green
        } else {
            Write-Host "[$currentDate] Push failed: $pushResult" -ForegroundColor Red
        }
    } else {
        Write-Host "[$currentDate] No local commits to push" -ForegroundColor Yellow
        Write-Host "[$currentDate] Repository is up to date!" -ForegroundColor Green
    }
}
catch {
    Write-Host "[$currentDate] Sync error: $_" -ForegroundColor Red
}

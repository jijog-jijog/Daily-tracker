# Daily tracker autocommit PowerShell script with sync
# Updates log.txt with current timestamp, commits changes, and syncs with remote

try {
    # Get current date and time
    $currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    
    Write-Host "Starting sync process..." -ForegroundColor Cyan
    
    # First, pull any remote changes
    Write-Host "Pulling remote changes..." -ForegroundColor Blue
    $pullResult = git pull origin main 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Pull successful" -ForegroundColor Green
    } else {
        Write-Host "Pull info: $pullResult" -ForegroundColor Yellow
    }
    
    # Update log.txt with current timestamp
    "Updated on $currentDate" | Out-File -FilePath "log.txt" -Encoding utf8
    
    # Add all changes to git
    git add .
    
    # Commit with timestamp message
    git commit -m "Daily sync: $currentDate"
    
    # Push changes to remote
    Write-Host "Pushing to remote..." -ForegroundColor Blue
    $pushResult = git push origin main 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Daily tracker updated, committed, and synced successfully!" -ForegroundColor Green
    } else {
        Write-Host "Commit successful but push failed: $pushResult" -ForegroundColor Red
    }
}
catch {
    Write-Host "Error during sync: $_" -ForegroundColor Red
}

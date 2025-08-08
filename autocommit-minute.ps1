# Minute-by-minute autocommit PowerShell script with sync
# Updates log.txt with current timestamp, commits changes, and syncs with remote every minute

while ($true) {
    try {
        # Get current date and time
        $currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
        
        Write-Host "[$currentDate] Starting sync cycle..." -ForegroundColor Cyan
        
        # First, try to pull any remote changes
        Write-Host "[$currentDate] Pulling remote changes..." -ForegroundColor Blue
        $pullResult = git pull origin main 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[$currentDate] Pull successful" -ForegroundColor Green
        } else {
            Write-Host "[$currentDate] Pull warning/info: $pullResult" -ForegroundColor Yellow
        }
        
        # Update log.txt with current timestamp
        "Updated on $currentDate" | Out-File -FilePath "log.txt" -Encoding utf8
        
        # Add all changes to git
        git add . 2>$null
        
        # Check if there are any changes to commit
        $status = git status --porcelain 2>$null
        if ($status) {
            # Commit with timestamp message
            git commit -m "Auto sync: $currentDate" 2>$null
            Write-Host "[$currentDate] Changes committed successfully" -ForegroundColor Green
            
            # Push changes to remote
            Write-Host "[$currentDate] Pushing to remote..." -ForegroundColor Blue
            $pushResult = git push origin main 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "[$currentDate] Push successful - Sync complete!" -ForegroundColor Green
            } else {
                Write-Host "[$currentDate] Push failed: $pushResult" -ForegroundColor Red
            }
        } else {
            Write-Host "[$currentDate] No local changes to commit" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "[$currentDate] Error: $_" -ForegroundColor Red
    }
    
    # Wait 60 seconds (1 minute) before next sync cycle
    Start-Sleep -Seconds 60
}

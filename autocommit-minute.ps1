# Minute-by-minute autocommit PowerShell script
# Updates log.txt with current timestamp and commits changes every minute

while ($true) {
    try {
        # Get current date and time
        $currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
        
        # Update log.txt with current timestamp
        "Updated on $currentDate" | Out-File -FilePath "log.txt" -Encoding utf8
        
        # Add all changes to git
        git add . 2>$null
        
        # Check if there are any changes to commit
        $status = git status --porcelain 2>$null
        if ($status) {
            # Commit with timestamp message
            git commit -m "Minute update: $currentDate" 2>$null
            Write-Host "[$currentDate] Changes committed successfully" -ForegroundColor Green
        } else {
            Write-Host "[$currentDate] No changes to commit" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "[$currentDate] Error: $_" -ForegroundColor Red
    }
    
    # Wait 60 seconds (1 minute) before next commit
    Start-Sleep -Seconds 60
}

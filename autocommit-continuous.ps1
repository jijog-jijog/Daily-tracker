

# Continuous autocommit PowerShell script - RUNS EVERY SECOND
# WARNING: This will create thousands of commits per day!

while ($true) {
    try {    
        # Get current date and time with seconds
        $currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
        
        # Update log.txt with current timestamp
        "Updated on $currentDate" | Out-File -FilePath "log.txt" -Encoding utf8
        
        # Add all changes to git
        git add . 2>$null
        
        # Commit with timestamp message
        git commit -m "Auto update: $currentDate" 2>$null
        
        Write-Host "[$currentDate] Committed successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    
    # Wait 1 second before next commit
    Start-Sleep -Seconds 1
}

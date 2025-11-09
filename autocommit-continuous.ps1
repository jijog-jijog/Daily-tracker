
while ($true) {
    try {    
   
        git commit -m "Auto update: $currentDate" 2>$null
        
        Write-Host "[$currentDate] Committed successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    
    # Wait 1 second before next commit
    Start-Sleep -Seconds 1
}

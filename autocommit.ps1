# Daily tracker autocommit PowerShell script
# Updates log.txt with current timestamp and commits changes

# Get current date and time
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Update log.txt with current timestamp
"Updated on $currentDate" | Out-File -FilePath "log.txt" -Encoding utf8

# Add all changes to git
git add .

# Commit with timestamp message
git commit -m "Daily update: $currentDate"

# Optional: Push to remote (uncomment if needed)
# git push origin main

Write-Host "Daily tracker updated and committed successfully!" -ForegroundColor Green

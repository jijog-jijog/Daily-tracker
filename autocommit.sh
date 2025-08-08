#!/bin/bash

# Daily tracker autocommit script
# Updates log.txt with current timestamp and commits changes

# Get current date and time
current_date=$(date "+%d/%m/%Y %H:%M:%S")

# Update log.txt with current timestamp
echo "Updated on $current_date" > log.txt

# Add all changes to git
git add .

# Commit with timestamp message
git commit -m "Daily update: $current_date"

# Optional: Push to remote (uncomment if needed)
# git push origin main

echo "Daily tracker updated and committed successfully!"
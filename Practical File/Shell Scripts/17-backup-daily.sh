#!/bin/bash

# Set the directory to back up and the backup location
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
DATE=$(date +%F)  # e.g., 2025-04-22
BACKUP_NAME="backup-$DATE.tar.gz"

# Create the backup using tar
tar -czf $BACKUP_DIR/$BACKUP_NAME $SOURCE_DIR

# Optional: Delete backups older than 7 days
find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;

echo "Backup completed for $SOURCE_DIR on $DATE"

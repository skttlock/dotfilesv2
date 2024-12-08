#!/bin/bash

# Backup Script: Backup specified directories to an external drive


# compress directories
# move compressed directories to external hard drive in a new directory titled the backup+ the date & time the backup occurred
#
# Configuration - Change these as needed
BACKUP_DESTINATION="/run/media/joshuaforeman/JOSH"  # Path to the external drive
DIRS_TO_BACKUP=(
                "$HOME/Downloads"
                "$HOME/Documents"
                "$HOME/Pictures"
                "$HOME/Videos"
                "$HOME/Music"
                "$HOME/Templates"
                "$HOME/.config/home-manager"
                )  # List of directories to back up

# Check if the external hard drive is mounted
if [ ! -d "$BACKUP_DESTINATION" ]; then
    echo "Error: External drive not found at $BACKUP_DESTINATION."
    echo "Please make sure the external drive is connected and mounted."
    exit 1
fi

# Create a unique backup folder with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="${BACKUP_DESTINATION}/backup_${TIMESTAMP}"
mkdir -p "$BACKUP_DIR"

# Function to perform the backup using rsync
backup_directory() {
    local dir=$1
    if [ -d "$dir" ]; then
        echo "Backing up: $dir"
        rsync -av --progress "$dir" "$BACKUP_DIR/"
        echo "Backup completed for: $dir"
    else
        echo "Directory does not exist: $dir"
    fi
}

# Perform the backup for each directory
for dir in "${DIRS_TO_BACKUP[@]}"; do
    backup_directory "$dir"
done

# Optional: Compress the backup folder (uncomment to enable)
# echo "Compressing backup folder..."
# tar -czf "${BACKUP_DESTINATION}/backup_${TIMESTAMP}.tar.gz" -C "$BACKUP_DESTINATION" "backup_${TIMESTAMP}"

# Final message with backup location
echo "Backup completed. All files are saved to: $BACKUP_DIR"


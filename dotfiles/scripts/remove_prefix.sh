#!/bin/bash

# rename_files.sh
# A simplified script to remove a specified string from the beginning of file names in a given directory.
#
# Author: Joshua Foreman
# Date: 2025-02-16
# Version: 1.3
# Created entirely with Microsoft Copilot
#

# Usage:
#   ./rename_files.sh <string-to-remove> [directory]

# Check if the first argument (string to remove) is provided
if [ -z "$1" ]; then
	echo "Error: <string-to-remove> is required."
	echo "Usage: $0 <string-to-remove> [directory]"
	exit 1
fi

# Assign the first argument to a variable
STRING_TO_REMOVE="$1"

# Assign the second argument to a variable, defaulting to the current directory
DIRECTORY="${2:-.}"

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
	echo "Error: Directory '$DIRECTORY' does not exist."
	exit 1
fi

# Change to the specified directory
cd "$DIRECTORY" || {
	echo "Error: Failed to change directory to '$DIRECTORY'"
	exit 1
}

# Loop through files that match the pattern
for file in "$STRING_TO_REMOVE"*; do
	# Check if the file exists
	if [ -e "$file" ]; then
		NEW_NAME="${file#$STRING_TO_REMOVE}"
		if ! mv "$file" "$NEW_NAME"; then
			echo "Error: Failed to rename '$file' to '$NEW_NAME'"
		fi
	fi
done

echo "Files renamed successfully."

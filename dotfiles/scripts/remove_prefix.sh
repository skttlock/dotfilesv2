#!/bin/bash

# rename_files.sh
# A script to remove a specified string from the beginning of file names in a given directory.
#
# Author: Joshua Foreman
# Date: 2025-02-16
# Version: 1.0
# Created entirely with Microsoft Copilot
#
# Usage:
#   ./rename_files.sh [options] <string-to-remove> [directory]
#
# Description:
#   This script removes the specified string from the beginning of file names in the given directory.
#   It includes options for creating backups, verbose output, dry runs, logging, and error logging.
#
# Arguments:
#   <string-to-remove>  The string to remove from the beginning of file names.
#   [directory]         The directory to operate on (defaults to the current working directory).
#
# Options:
#   -h, --help          Show this help message and exit.
#   -b, --backup        Create backups of the original files.
#   -v, --verbose       Print detailed information about the operations.
#   -d, --dry-run       Show what changes would be made without renaming files.
#   -l, --log FILE      Log the operations to the specified file.
#   -e, --error-log FILE Log errors to the specified file.
#   -y, --yes           Automatically confirm all prompts.

# Function to display help message
show_help() {
	echo "Usage: $0 [options] <string-to-remove> [directory]"
	echo
	echo "This script removes the specified string from the beginning of file names in the given directory."
	echo
	echo "Arguments:"
	echo "  <string-to-remove>  The string to remove from the beginning of file names."
	echo "  [directory]         The directory to operate on (defaults to the current working directory)."
	echo
	echo "Options:"
	echo "  -h, --help          Show this help message and exit."
	echo "  -b, --backup        Create backups of the original files."
	echo "  -v, --verbose       Print detailed information about the operations."
	echo "  -d, --dry-run       Show what changes would be made without renaming files."
	echo "  -l, --log FILE      Log the operations to the specified file."
	echo "  -e, --error-log FILE Log errors to the specified file."
	echo "  -y, --yes           Automatically confirm all prompts."
}

# Initialize options
BACKUP=false
VERBOSE=false
DRY_RUN=false
LOG_FILE=""
ERROR_LOG_FILE=""
AUTO_CONFIRM=false

# Parse options
while [[ "$1" == -* ]]; do
	case "$1" in
	-h | --help)
		show_help
		exit 0
		;;
	-b | --backup)
		BACKUP=true
		;;
	-v | --verbose)
		VERBOSE=true
		;;
	-d | --dry-run)
		DRY_RUN=true
		;;
	-l | --log)
		shift
		LOG_FILE="$1"
		;;
	-e | --error-log)
		shift
		ERROR_LOG_FILE="$1"
		;;
	-y | --yes)
		AUTO_CONFIRM=true
		;;
	*)
		echo "Unknown option: $1"
		show_help
		exit 1
		;;
	esac
	shift
done

# Check if the first argument (string to remove) is provided
if [ -z "$1" ]; then
	echo "Error: <string-to-remove> is required."
	show_help
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
cd "$DIRECTORY" || exit

# Loop through files that match the pattern
for file in "$STRING_TO_REMOVE"*; do
	# Check if the file exists
	if [ -e "$file" ]; then
		NEW_NAME="${file#$STRING_TO_REMOVE}"
		if $VERBOSE; then
			echo "Renaming '$file' to '$NEW_NAME'"
		fi
		if $DRY_RUN; then
			continue
		fi
		if ! $AUTO_CONFIRM; then
			read -p "Are you sure you want to rename '$file' to '$NEW_NAME'? [y/N] " confirm
			if [[ "$confirm" != [yY] ]]; then
				continue
			fi
		fi
		if $BACKUP; then
			cp "$file" "$file.bak"
		fi
		if ! mv "$file" "$NEW_NAME"; then
			echo "Error renaming '$file' to '$NEW_NAME'" | tee -a "$ERROR_LOG_FILE"
		fi
		if [ -n "$LOG_FILE" ]; then
			echo "Renamed '$file' to '$NEW_NAME'" >>"$LOG_FILE"
		fi
	fi
done

echo "Files renamed successfully."

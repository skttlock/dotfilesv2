#!/bin/bash
# Script Name: lines_to_files_in_dir.sh
# Version: 1.5
# Author: Joshua Foreman
# Date: 2024-12-06
# Description: This script processes all files with the .awk_input extension in the current directory. It extracts the first, second, third, third-to-last, and last words from each line, removes any special characters, creates filenames, and writes each line to its respective file in a directory named after the input filename.
# Generated with the help of Microsoft Copilot

for file in *.awk_input; do
  # Create a directory named after the input file (without the extension)
  dirname="${file%.awk_input}"
  mkdir -p "$dirname"
  
  # Process the file and output to the created directory
  awk -v dir="$dirname" '{gsub(/[^a-zA-Z0-9]/, "", $1); gsub(/[^a-zA-Z0-9]/, "", $2); gsub(/[^a-zA-Z0-9]/, "", $3); gsub(/[^a-zA-Z0-9]/, "", $(NF-2)); gsub(/[^a-zA-Z0-9]/, "", $NF); filename = dir "/" $1 "_" $2 "_" $3 "_" $(NF-2) "_" $NF ".txt"; print > filename}' "$file"
done

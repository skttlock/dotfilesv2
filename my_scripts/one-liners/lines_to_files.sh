#!/bin/bash
# Script Name: line_to_file_extractor.sh
# Version: 1.4
# Author: Joshua Foremaan
# Date: 2024-12-06
# Description: This script processes all files with the .awk_input extension in the current directory. It extracts the first, second, third, third-to-last, and last words from each line, removes any special characters, creates filenames, and writes each line to its respective file.
# Generated with the help of Microsoft Copilot

for file in *.awk_input; do
  awk '{gsub(/[^a-zA-Z0-9]/, "", $1); gsub(/[^a-zA-Z0-9]/, "", $2); gsub(/[^a-zA-Z0-9]/, "", $3); gsub(/[^a-zA-Z0-9]/, "", $(NF-2)); gsub(/[^a-zA-Z0-9]/, "", $NF); filename = $1 "_" $2 "_" $3 "_" $(NF-2) "_" $NF ".txt"; print > filename}' "$file"
done

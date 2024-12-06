#!/bin/bash
# Script Name: line_to_file_extractor.sh
# Version: 1.2
# Author: Your Name
# Date: 2024-12-06
# Description: This awk command extracts the first, second, third, and last words from each line of _input.txt, removes any special characters, creates filenames, and writes each line to its respective file.
# Generated with the help of Microsoft Copilot

awk '{gsub(/[^a-zA-Z0-9]/, "", $1); gsub(/[^a-zA-Z0-9]/, "", $2); gsub(/[^a-zA-Z0-9]/, "", $3); gsub(/[^a-zA-Z0-9]/, "", $NF); filename = $1 "_" $2 "_" $3 "_" $NF ".txt"; print > filename}' _input.txt


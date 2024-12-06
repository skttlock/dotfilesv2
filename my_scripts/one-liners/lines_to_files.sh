#!/bin/bash
# Script Name: line_to_file_extractor.sh
# Version: 1.1
# Author: Your Name
# Date: 2024-12-06
# Description: This awk command extracts the first, second, third, and last words from each line of input.txt to create filenames, then writes each line to its respective file.
# Generated with the help of Microsoft Copilot

awk '{filename = $1 "_" $2 "_" $3 "_" $NF ".txt"; print > filename}' input.txt

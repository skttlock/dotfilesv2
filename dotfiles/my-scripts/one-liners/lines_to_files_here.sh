#!/bin/bash
#===============================================================================
#
#          FILE: lines_to_files_here.sh
#
#         USAGE: ./lines_to_files_here.sh
#
#   DESCRIPTION: This script processes .awk_input files, cleans specific fields,
#                and constructs filenames based on the number of fields in each line.
#                It saves the processed output in the current directory.
#
#       OPTIONS: ---
#  REQUIREMENTS: awk
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Joshua Foreman
#           LLM: Microsoft Copilot
#  ORGANIZATION: ---
#       CREATED: 12/06/2024
#      REVISION: ---
#===============================================================================

awk '
{
    # Variables to hold cleaned fields
    clean1 = $1
    clean2 = $2
    clean3 = $3
    cleanNF3 = $(NF-3)
    cleanNF2 = $(NF-2)
    cleanNF = $NF

    # Clean up only the fields used in the filename
    gsub(/[^a-zA-Z0-9]/, "", clean1)
    gsub(/[^a-zA-Z0-9]/, "", clean2)
    gsub(/[^a-zA-Z0-9]/, "", clean3)
    gsub(/[^a-zA-Z0-9]/, "", cleanNF3)
    gsub(/[^a-zA-Z0-9]/, "", cleanNF2)
    gsub(/[^a-zA-Z0-9]/, "", cleanNF)

    # Construct filename based on the number of fields
    if (NF >= 7) {
        filename = clean1 "_" clean3 "_" cleanNF3 "_" cleanNF2 "_" cleanNF ".txt"
    } else if (NF == 6) {
        filename = clean1 "_" clean3 "_" cleanNF2 "_" cleanNF ".txt"
    } else if (NF == 5) {
        filename = clean1 "_" clean2 "_" clean3 "_" cleanNF ".txt"
    } else if (NF == 4) {
        filename = clean1 "_" clean2 "_" cleanNF2 "_" cleanNF ".txt"
    } else if (NF == 3) {
        filename = clean1 "_" cleanNF2 "_" cleanNF ".txt"
    } else {
        # Skip lines with fewer than 3 words
        print "Line skipped due to insufficient words: " $0 > "/dev/stderr"
        next
    }

    # Check if the file already exists
    if (system("[ -e " filename " ]") == 0) {
        print "File already exists, skipping: " filename > "/dev/stderr"
    } else {
        # Print the line to the constructed filename
        print > filename
    }
}' *.awk_input

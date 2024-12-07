#!/bin/bash

# Check if the fonts directory exists
if [ ! -d "./fonts" ]; then
  echo "Fonts directory not found!"
  exit 1
fi

# Check if there is exactly one .svg file in the current directory
svg_file=$(ls *.svg 2>/dev/null)
if [ $(echo "$svg_file" | wc -l) -ne 1 ]; then
  echo "There should be exactly one .svg file in the current directory!"
  exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p output

# Create a temporary directory for extracting fonts
temp_dir=$(mktemp -d)

# Loop through each compressed font archive in the fonts directory
for archive in ./fonts/*; do
  # Extract the archive to the temporary directory
  case "$archive" in
    *.zip) unzip -q "$archive" -d "$temp_dir" ;;
    *.tar.gz) tar -xzf "$archive" -C "$temp_dir" ;;
    *.tar.bz2) tar -xjf "$archive" -C "$temp_dir" ;;
    *.tar.xz) tar -xJf "$archive" -C "$temp_dir" ;;
    *) echo "Unsupported archive format: $archive" ;;
  esac
done

# Loop through each font file in the temporary directory
for font in "$temp_dir"/*; do
  # Extract the font name without the path and extension
  font_name=$(basename "$font" | sed 's/\.[^.]*$//')
  
  # Create a new SVG file for each font
  output_file="output/${font_name}.svg"
  cp "$svg_file" "$output_file"
  
  # Replace the font-family in the SVG file with the current font
  sed -i "s/font-family:[^;]*;/font-family:${font_name};/g" "$output_file"
done

# Clean up the temporary directory
rm -rf "$temp_dir"

echo "SVG files have been generated in the output directory."

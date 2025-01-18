#!/bin/bash

# Check if the input SVG file exists
if [ ! -f input.svg ]; then
  echo "input.svg file not found!"
  exit 1
fi

# Check if the font_options directory exists
if [ ! -d font_options ]; then
  echo "font_options directory not found!"
  exit 1
fi

# Loop through each font file in the font_options directory
for font in font_options/*; do
  # Extract the font name without the path and extension
  font_name=$(basename "$font" | sed 's/\.[^.]*$//')
  
  # Create a new SVG file for each font
  output_file="output_${font_name}.svg"
  
  # Use sed to replace the font-family in the input SVG file and save to the new SVG file
  sed "s/font-family:[^;]*;/font-family:'$font_name';/" input.svg > "$output_file"
  
  echo "Generated $output_file with font $font_name"
done

#!/bin/bash

# Get a list of all PDF files in the current directory
pdf_files=(*.pdf)

# Check if there are any PDF files
if [ ${#pdf_files[@]} -eq 0 ]; then
    echo "No PDF files found in the current directory."
    exit 1
fi

# Loop through all PDF files
for pdf in "${pdf_files[@]}"; do
    # Remove the .pdf extension
    base_name="${pdf%.*}"

    # Convert the PDF to SVG
    pdf2svg "$pdf" "${base_name}.svg"
done

echo "Conversion complete."


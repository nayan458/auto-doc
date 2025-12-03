#!/bin/bash

# Create output directory
OUTPUT_DIR="collected-readmes"
mkdir -p "$OUTPUT_DIR"

# Function to check if path should be ignored
should_ignore() {
    local path="$1"
    
    # Check if .readmeIgnore exists
    if [[ ! -f .readmeIgnore ]]; then
        return 1  # Don't ignore if file doesn't exist
    fi
    
    # Read ignore patterns and check against path
    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
        # Skip empty lines and comments
        [[ -z "$pattern" || "$pattern" =~ ^[[:space:]]*# ]] && continue
        
        # Remove leading/trailing whitespace
        pattern=$(echo "$pattern" | xargs)
        
        # Check if path matches pattern
        if [[ "$path" == *"$pattern"* ]]; then
            return 0  # Should ignore
        fi
    done < .readmeIgnore
    
    return 1  # Don't ignore
}

# Find and copy README files
echo "Collecting README files..."
find . -type f -iname "README.md" | while read -r file; do
    # Skip if in ignored path
    if should_ignore "$file"; then
        echo "Skipping (ignored): $file"
        continue
    fi
    
    # Create destination path
    dest="$OUTPUT_DIR/${file#./}"
    
    # Create directory structure
    mkdir -p "$(dirname "$dest")"
    
    # Copy file
    cp "$file" "$dest"
    echo "Copied: $file"
done

# Generate nav.json
echo ""
echo "Generating navigation JSON..."

# Start JSON structure
echo "{" > nav.json

# Find all README files and build JSON
first=true
find "$OUTPUT_DIR" -type f -iname "README.md" | sort | while read -r file; do
    # Get the directory name (parent folder)
    dir_path=$(dirname "$file")
    folder_name=$(basename "$dir_path")
    
    # Get relative path from OUTPUT_DIR
    rel_path="${file#$OUTPUT_DIR/}"
    
    # Handle root level READMEs
    if [[ "$folder_name" == "$OUTPUT_DIR" ]]; then
        folder_name="root"
        rel_path="README.md"
    fi
    
    # Add comma if not first entry
    if [[ "$first" == true ]]; then
        first=false
    else
        echo "," >> nav.json
    fi
    
    # Add JSON entry with @readmes/ prefix
    echo -n "  \"$folder_name\": \"@readmes/$rel_path\"" >> nav.json
done

# Close JSON structure
echo "" >> nav.json
echo "}" >> nav.json

echo ""
echo "✓ Collection complete!"
echo "  - README files copied to: $OUTPUT_DIR/"
echo "  - Navigation JSON saved to: nav.json"
echo ""
echo "Example .readmeIgnore format:"
echo "  node_modules"
echo "  .git"
echo "  vendor"
echo "  # Lines starting with # are comments"
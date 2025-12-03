#!/bin/bash

TARGET="doc-viewer"

echo "Scanning current directory..."
echo

# Collect items except TARGET
items=()
while IFS= read -r entry; do
    items+=("$entry")
done < <(find . -mindepth 1 -maxdepth 1 ! -name "$TARGET")

# If nothing to delete
if [ ${#items[@]} -eq 0 ]; then
    echo "Nothing to delete. Only '$TARGET' exists."
    exit 0
fi

echo "The following TOP-LEVEL items will be deleted:"
printf '  %s\n' "${items[@]}"
echo
read -p "Are you sure you want to delete these items? (y/N): " confirm

# Convert to lowercase
confirm=$(echo "$confirm" | tr 'A-Z' 'a-z')

if [ "$confirm" == "y" ]; then
    echo "Deleting..."
    rm -rf -- "${items[@]}"
    echo "Done."
else
    echo "Aborted."
fi

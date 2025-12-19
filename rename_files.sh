#!/bin/bash
set -e

FOLDER="$1"

[ -z "$FOLDER" ] && { echo "Rename-walls in : $0" exit 1; }
[ -d "$FOLDER" ] || { echo "Error: $FOLDER not a directory"; exit 1; }

count=1

for file in "$FOLDER"/*; do
    [ -f "$file" ] || continue

    ext="${file##*.}"
    newname=$(printf "%05d.%s" "$count" "$ext")

    mv -i -- "$file" "$FOLDER/$newname"
    count=$((count + 1))
done

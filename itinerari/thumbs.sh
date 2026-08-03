#!/bin/bash

# Cerca ricorsivamente tutti i file chiamati thumb.webp
find . -type f -name "thumb.webp" | while read -r file; do
    dir=$(dirname "$file")

    original="$dir/thumb.webp"
    thumb640="$dir/thumb-640.webp"
    thumb480="$dir/thumb-480.webp"
    thumb320="$dir/thumb-320.webp"

    echo "Elaboro: $original"

    # Rinomina thumb.webp in thumb-640.webp
    mv "$original" "$thumb640"

    # Crea le copie
    cp "$thumb640" "$thumb480"
    cp "$thumb640" "$thumb320"
done

echo "Operazione completata."
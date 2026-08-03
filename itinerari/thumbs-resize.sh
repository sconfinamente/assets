#!/bin/bash

find . -type f -name "thumb.webp" | while read -r file; do
    dir=$(dirname "$file")

    echo "Elaboro: $file"

    # Crea le versioni ridimensionate
    ./magick/magick "$file" -resize 640x "$dir/thumb-640.webp"
    ./magick/magick "$file" -resize 480x "$dir/thumb-480.webp"
    ./magick/magick "$file" -resize 320x "$dir/thumb-320.webp"

    # Elimina il file originale
    rm "$file"
done

echo "Operazione completata."
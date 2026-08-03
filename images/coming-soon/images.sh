#!/bin/bash

MAGICK="/c/vigetti/tools/magick/magick.exe"

find . -type f -name "*.webp" \
  ! -name "*-640.webp" \
  ! -name "*-480.webp" \
  ! -name "*-320.webp" | while read -r file; do

    dir=$(dirname "$file")
    filename=$(basename "$file" .webp)

    echo "Elaboro: $file"

    if "$MAGICK" "$file" -resize 640x "$dir/${filename}-640.webp" && \
       "$MAGICK" "$file" -resize 480x "$dir/${filename}-480.webp" && \
       "$MAGICK" "$file" -resize 320x "$dir/${filename}-320.webp"; then

        echo "Creati: ${filename}-640.webp, ${filename}-480.webp, ${filename}-320.webp"
        rm "$file"
    else
        echo "ERRORE nella conversione di $file"
    fi
done

echo "Operazione completata."
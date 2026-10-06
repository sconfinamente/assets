#!/bin/bash

# ============================================================
# CONFIGURAZIONE
# ============================================================

SCRIPT_DIR="/c/vigetti/tools"
MAGICK="$SCRIPT_DIR/ImageMagick/magick.exe"

# ============================================================
# CONTROLLI
# ============================================================

if [ ! -f "$MAGICK" ]; then
    echo ""
    echo "ERRORE: ImageMagick non trovato."
    echo ""
    echo "Mi aspetto:"
    echo "  $SCRIPT_DIR/ImageMagick/magick.exe"
    echo ""
    exit 1
fi

SOURCE="$1"
DEST="$2"

if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
    echo ""
    echo "Uso:"
    echo "  ./convert-webp.sh <cartella-sorgente> <cartella-destinazione>"
    echo ""
    echo "Esempio:"
    echo "  ./convert-webp.sh /c/Foto/Olympic /c/Foto/Olympic-webp"
    echo ""
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo ""
    echo "ERRORE: cartella sorgente non trovata:"
    echo "  $SOURCE"
    echo ""
    exit 1
fi

mkdir -p "$DEST"

# ============================================================
# CONVERSIONE
# ============================================================

COUNT=0

find "$SOURCE" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" \
\) | while read -r file; do

    # Percorso relativo rispetto alla sorgente
    relative="${file#$SOURCE/}"

    # Nome senza estensione
    output_base="$DEST/${relative%.*}"

    # Crea la sottocartella
    mkdir -p "$(dirname "$output_base")"

    echo ""
    echo "----------------------------------------"
    echo "File: $relative"

    # --------------------------------------------------------
    # 640px
    # --------------------------------------------------------

    echo "  -> ${output_base##*/}-640.webp"

    "$MAGICK" "$file" \
        -auto-orient \
        -resize "640x640>" \
        -quality 82 \
        "${output_base}-640.webp"

    if [ $? -ne 0 ]; then
        echo "  ERRORE nella conversione 640px"
        continue
    fi

    # --------------------------------------------------------
    # 1200px
    # --------------------------------------------------------

    echo "  -> ${output_base##*/}-1200.webp"

    "$MAGICK" "$file" \
        -auto-orient \
        -resize "1200x1200>" \
        -quality 82 \
        "${output_base}-1200.webp"

    if [ $? -ne 0 ]; then
        echo "  ERRORE nella conversione 1200px"
        continue
    fi

    echo "  OK"

    COUNT=$((COUNT + 1))

done

echo ""
echo "========================================"
echo "Conversione completata."
echo "========================================"
echo ""
echo "Sono state elaborate le immagini JPG/JPEG."
echo ""
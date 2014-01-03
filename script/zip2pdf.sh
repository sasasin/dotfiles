#!/bin/sh

export MAGICK_TEMPORARY_PATH=$HOME

ls "$@" | while read f; do
    echo "converting $f "
    sleep 1
    OUTDIR=$(get_timestamp.sh).$$
    mkdir "${OUTDIR}"
    unzip -q -o -j "$f" -d "${OUTDIR}"
    rm -f "${OUTDIR}".pdf

    dir2pdf.sh "${OUTDIR}"    

    rm -rf "${OUTDIR}"
done

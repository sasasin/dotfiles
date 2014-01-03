#!/bin/sh

export MAGICK_TEMPORARY_PATH=$HOME

find "$@" -type d | while read f; do
    OUTDIR=$f
    rm -f "$(pwd)"/"${OUTDIR}".pdf
    echo "converting $f "

    (jpg2pdf.pl \
	-d "$(pwd)"/"${OUTDIR}" \
	-o "$(pwd)"/"${OUTDIR}".pdf \
	-s "A4" -t "" -a "" \
	) \
	|| convert -limit memory 2gb -limit map 2gb \
	"$(pwd)"/"${OUTDIR}"/*.{jpg,JPG,jpeg,JPEG,png,PNG} \
	"$(pwd)"/"${OUTDIR}".pdf

    run_pdfdirection.sh \
	"$(pwd)"/"${OUTDIR}".pdf \
	"$(pwd)"/"${OUTDIR}".R2L.pdf \
	"R2L"

    mv "$(pwd)"/"${OUTDIR}".R2L.pdf \
       "$(pwd)"/"${OUTDIR}".pdf

done

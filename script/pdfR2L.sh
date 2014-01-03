#!/bin/sh

ls "$@" | while read f; do
    run_pdfdirection.sh \
	"$f" \
	"$f".R2L \
	"R2L"

    mv  "$f".R2L \
	"$f"
done
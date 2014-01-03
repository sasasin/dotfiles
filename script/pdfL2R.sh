#!/bin/sh

ls "$@" | while read f; do
    run_pdfdirection.sh \
	"$f" \
	"$f".L2R \
	"L2R"

    mv  "$f".L2R \
	"$f"
done
#!/bin/sh -v

find $HOME -type f \
| grep -E '\.sqlite$' \
| while read f; do
    echo "$f"
    sqlite3 "$f" vacuum
    sqlite3 "$f" reindex
    sqlite3 "$f" analyze
done

#!/bin/sh
ls "$@" | while read f; do
    BEFORE_NAME=$f
    AFTER_NAME=$(ls $f | awk 'BEGIN{FS="_"}{print "$0" $1 "." $2 "." $3}' | awk 'BEGIN{FS="."}{if ($3=="jpg"){$3 = "1"};printf("HOGE.%s.%05d.jpg\n",$2,$3)}')
    mv $BEFORE_NAME $AFTER_NAME
done
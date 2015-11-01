#!/bin/sh -v
# シャープにする
mogrify -sharpen 4x4 "$@"

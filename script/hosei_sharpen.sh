#!/bin/sh -v
# シャープにする
magick mogrify -sharpen 4x4 "$@"

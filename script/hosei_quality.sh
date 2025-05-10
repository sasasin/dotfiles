#!/bin/bash -v
# 各補正をして肥大化した画像をスリムにする
magick mogrify -quality 25 "$@"

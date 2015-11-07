#!/bin/bash -v
# 各補正をして肥大化した画像をスリムにする
mogrify -quality 25 "$@"

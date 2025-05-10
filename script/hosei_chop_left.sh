#!/bin/bash -v
# 左の削り取り
magick mogrify -crop +50+0 "$@"

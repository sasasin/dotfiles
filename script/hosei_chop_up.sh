#!/bin/bash -v
# 上の削り取り
magick mogrify -crop +0+50 "$@"

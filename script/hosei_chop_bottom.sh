#!/bin/bash -v
# 下の削り取り
magick mogrify -crop +0-50 "$@"

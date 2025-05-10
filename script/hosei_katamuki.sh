#!/bin/bash -v
# 自動傾き補正
magick mogrify -deskew 40% "$@"

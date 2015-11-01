#!/bin/bash -v
# 自動傾き補正
mogrify -deskew 40% "$@"

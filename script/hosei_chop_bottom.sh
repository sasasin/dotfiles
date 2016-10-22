#!/bin/bash -v
# 下の削り取り
mogrify -crop +0-50 "$@"

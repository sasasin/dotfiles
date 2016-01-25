#!/bin/bash -v
# 左端の切り捨て
mogrify -chop 50x0 "$@"

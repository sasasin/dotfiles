#!/bin/bash -v
# 裏写り補正。裏写りが消えるまで何度か実行する。
mogrify -modulate 115 -contrast "$@"

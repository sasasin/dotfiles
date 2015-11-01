#!/bin/bash -v
# 白黒クッキリ補正。liner-stretchによる補正では、ほぼ白/ほぼ黒が潰れてしまう問題があったため、別解として作成
mogrify -level '25%,90%' "$@"

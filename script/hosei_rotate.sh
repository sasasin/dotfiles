#!/bin/bash -v
# 横倒しにした画像を縦にする
ads2500w_rename.sh *.jpg
wait
hosei_rotate90.sh *0.jpg &
hosei_rotate90.sh *2.jpg &
hosei_rotate90.sh *4.jpg &
hosei_rotate90.sh *6.jpg &
hosei_rotate90.sh *8.jpg &
wait
hosei_rotate270.sh *1.jpg &
hosei_rotate270.sh *3.jpg &
hosei_rotate270.sh *5.jpg &
hosei_rotate270.sh *7.jpg &
hosei_rotate270.sh *9.jpg &
wait

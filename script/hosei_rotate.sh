#!/bin/bash -v
# 横倒しにした画像を縦にする
hosei_rotate_right.sh *0.jpg &
hosei_rotate_right.sh *2.jpg &
hosei_rotate_right.sh *4.jpg &
hosei_rotate_right.sh *6.jpg &
hosei_rotate_right.sh *8.jpg &
wait
hosei_rotate_left.sh *1.jpg &
hosei_rotate_left.sh *3.jpg &
hosei_rotate_left.sh *5.jpg &
hosei_rotate_left.sh *7.jpg &
hosei_rotate_left.sh *9.jpg &
wait

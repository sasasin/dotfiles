#!/bin/bash -v
hosei_rotate_left.sh *0.jpg &
hosei_rotate_left.sh *2.jpg &
hosei_rotate_left.sh *4.jpg &
hosei_rotate_left.sh *6.jpg &
hosei_rotate_left.sh *8.jpg &
wait
hosei_rotate_right.sh *1.jpg &
hosei_rotate_right.sh *3.jpg &
hosei_rotate_right.sh *5.jpg &
hosei_rotate_right.sh *7.jpg &
hosei_rotate_right.sh *9.jpg &
wait

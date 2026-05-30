# bash の history のガバガバ記憶を是正する
# https://chatgpt.com/c/6a084a37-4ce8-83ec-a64a-d8a0c12e8104
# Bash history は補助扱い
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
shopt -s cmdhist
shopt -s lithist

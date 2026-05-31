if [[ ! -f ~/.bash-completion-ghq.sh ]]; then
    curl -fsSL https://raw.githubusercontent.com/x-motemen/ghq/refs/heads/master/misc/bash/_ghq -o ~/.bash-completion-ghq.sh
fi
source ~/.bash-completion-ghq.sh

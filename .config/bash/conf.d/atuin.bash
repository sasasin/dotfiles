# https://docs.atuin.sh/cli/guide/installation/
if [[ ! -f ~/.bash-preexec.sh ]]; then
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
fi
source ~/.bash-preexec.sh
# https://hub.atuin.sh/
# https://docs.atuin.sh/cli/
if [[ $- == *i* ]] && [[ "${TERM:-}" != "dumb" ]] && command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash --disable-ai --disable-up-arrow)"
fi

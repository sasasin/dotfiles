# https://docs.atuin.sh/cli/guide/installation/
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
# https://hub.atuin.sh/
# https://docs.atuin.sh/cli/
if [[ $- == *i* ]] && [[ "${TERM:-}" != "dumb" ]] && command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash)"
fi

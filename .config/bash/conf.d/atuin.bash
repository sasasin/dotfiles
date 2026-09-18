# https://docs.atuin.sh/cli/guide/installation/
if [[ ! -f ~/.bash-preexec.sh ]]; then
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
fi
# Ubuntu's VTE shell integration also uses PS0.  On Bash 5.3+, the two PS0
# hooks can be printed literally instead of being executed (bash-preexec#186).
# Keep VTE's own PS0 content, but move bash-preexec to its DEBUG backend.
__bash_preexec_vte_ps0=0
if [[ ${PS0-} == *'vte.shell.preexec'* || ${PS0-} == *'133;C'* ]]; then
    __bash_preexec_vte_ps0=1
fi

shopt -s promptvars
if [[ -f ~/.bash-preexec.sh ]]; then
    source ~/.bash-preexec.sh
fi

if (( __bash_preexec_vte_ps0 )) && declare -F __bp_hook_preexec_into_debug >/dev/null; then
    __bash_preexec_ps0_hook='${ __bp_invoke_preexec_from_ps0 "$_" >&2; }'
    if [[ ${PS0-} == *"$__bash_preexec_ps0_hook" ]]; then
        PS0=${PS0%"$__bash_preexec_ps0_hook"}
    fi
    __bp_hook_preexec_into_debug
    __bp_hook_preexec_proc=__bp_hook_preexec_into_debug
    unset __bash_preexec_ps0_hook
fi
unset __bash_preexec_vte_ps0

# https://hub.atuin.sh/
# https://docs.atuin.sh/cli/
# Some real terminal sessions advertise TERM=dumb, so use the TTY check rather
# than disabling Atuin solely from TERM.
if [[ $- == *i* ]] && [[ -t 0 && -t 1 ]] && command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash --disable-ai --disable-up-arrow)"
fi

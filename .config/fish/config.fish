function fish_user_key_bindings
    bind \cr peco_select_history # Bind for prco history to Ctrl+r
end

set -x GHQ_SELECTOR peco

set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/scripts $PATH
set -x PATH /usr/share/nodejs/yarn/bin $PATH
set -x PATH $HOME/.linkerd2/bin $PATH

set -x QT_AUTO_SCREEN_SCALE_FACTOR 2

set -x AWS_DEFAULT_REGION "ap-northeast-1"
set -x AWS_PROFILE "sasasin"

set -x AWS_VAULT_BACKEND "pass"
set -x AWS_VAULT_PASS_PREFIX "aws-vault"
set -x AWS_SESSION_TOKEN_TTL "3h"

set -x DOCKER_HOST "ssh://limadocker:60006"

balias mi "micro"
#balias pbcopy "xclip -selection c"
#balias pbpaste "xclip -selection c -o"

#source ~/.asdf/asdf.fish

/opt/homebrew/bin/brew shellenv | source

source (brew --prefix)/opt/asdf/libexec/asdf.fish

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

#source /usr/local/share/fish/vendor_completions.d/*.fish

# https://starship.rs/
starship init fish | source

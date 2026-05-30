# macOS specific bash configuration translated from fish/config.fish

prepend_path() {
  [[ -d "$1" ]] || return

  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

if [[ -x /opt/homebrew/bin/brew ]]; then
  prepend_path /opt/homebrew/bin
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if command -v brew >/dev/null 2>&1; then
  brew_prefix="$(brew --prefix)"

  prepend_path "$brew_prefix/opt/gnu-getopt/bin"
  prepend_path "$brew_prefix/opt/mysql-client/bin"

  if [[ -r "$brew_prefix/etc/profile.d/bash_completion.sh" ]]; then
    source "$brew_prefix/etc/profile.d/bash_completion.sh"
  elif [[ -r "$brew_prefix/share/bash-completion/bash_completion" ]]; then
    source "$brew_prefix/share/bash-completion/bash_completion"
  fi

  unset brew_prefix
fi

prepend_path "$HOME/.local/bin"
prepend_path "$HOME/go/bin"
prepend_path "$HOME/scripts"
prepend_path /usr/share/nodejs/yarn/bin
prepend_path "$HOME/.linkerd2/bin"
prepend_path "$HOME/.rd/bin"

export QT_AUTO_SCREEN_SCALE_FACTOR=2

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_PROFILE=dev

export AWS_VAULT_BACKEND=keychain
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_SESSION_TOKEN_TTL=3h

alias mi='micro'

unset -f prepend_path

# fzf --bash

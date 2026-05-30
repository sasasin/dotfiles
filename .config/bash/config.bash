# $HOME/.bashrc でこのファイルを . する

# OS ごとの rc を読む
case "$OSTYPE" in
  linux*)
    [[ -f ~/.config/bash/os/linux.bash ]] && source ~/.config/bash/os/linux.bash
    ;;
  darwin*)
    [[ -f ~/.config/bash/os/darwin.bash ]] && source ~/.config/bash/os/darwin.bash
    ;;
  msys*|cygwin*|win32*)
    [[ -f ~/.config/bash/os/windows.bash ]] && source ~/.config/bash/os/windows.bash
    ;;
  *)
    echo "Unknown: $OSTYPE"
    ;;
esac

# Load config
for f in ~/.config/bash/conf.d/*.bash; do
    [ -f "$f" ] && eval "$(cat "$f")"
done

# Load functions
for f in ~/.config/bash/functions/*.bash; do
    [ -f "$f" ] && eval "$(cat "$f")"
done

# Load completions
for f in ~/.config/bash/completions/*.bash; do
    [ -f "$f" ] && eval "$(cat "$f")"
done

# https://opencode.ai/docs/ja/tui/
export EDITOR='code --wait'

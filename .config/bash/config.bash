# $HOME/.bashrc でこのファイルを . する

# Resolve this directory relative to the location of this script
BASH_CONFIG_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# OS ごとの rc を読む
case "$OSTYPE" in
  linux*)
    [[ -f "$BASH_CONFIG_DIR/os/linux.bash" ]] && source "$BASH_CONFIG_DIR/os/linux.bash"
    ;;
  darwin*)
    [[ -f "$BASH_CONFIG_DIR/os/darwin.bash" ]] && source "$BASH_CONFIG_DIR/os/darwin.bash"
    ;;
  msys*|cygwin*|win32*)
    [[ -f "$BASH_CONFIG_DIR/os/windows.bash" ]] && source "$BASH_CONFIG_DIR/os/windows.bash"
    ;;
  *)
    echo "Unknown: $OSTYPE"
    ;;
esac

# Load config
for f in "$BASH_CONFIG_DIR/conf.d/"*.bash; do
    [ -f "$f" ] && eval "$(cat "$f")"
done

# Load functions
for f in "$BASH_CONFIG_DIR/functions/"*.bash; do
    [ -f "$f" ] && eval "$(cat "$f")"
done

# Load completions
for f in "$BASH_CONFIG_DIR/completions/"*.bash; do
    [ -f "$f" ] && eval "$(cat "$f")"
done

# https://opencode.ai/docs/ja/tui/
export EDITOR='code --wait'

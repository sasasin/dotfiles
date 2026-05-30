# interactive shell かつ TERM=dumb でない場合だけ starship を有効化
# OpenCode などからシェルコマンドを投げるときは TERM=dumb になる場合がある
if [[ $- == *i* ]] && [[ "${TERM:-}" != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

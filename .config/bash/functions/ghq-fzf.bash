# ghq + fzf でリポジトリ移動
ghq-fzf() {
  local repo

  repo="$(ghq list -p | fzf-safe)" || return
  [[ -z "$repo" ]] && return

  cd "$repo" || return
}

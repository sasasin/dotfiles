fzf-safe() {
  wincon-clear-vt-input
  command fzf "$@"
  local status=$?
  tty-soft-reset
  return "$status"
}

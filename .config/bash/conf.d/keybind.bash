# 対話シェルでのみキーバインドを設定
if [[ $- == *i* ]]; then
  # Ctrl+g: ghq リポジトリ選択 → cd
  bind -x '"\C-g": ghq-fzf'
fi

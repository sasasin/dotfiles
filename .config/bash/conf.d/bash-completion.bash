# _init_completion などを completion が利用している。
# Git for Windows の bash にバンドルされていない。
# bash-completion は winget や scoop で配布されていない。
# ghq get https://github.com/scop/bash-completion
# したものを source することにした
# macOS は homebrew で入手したものを利用する
[[ -f ~/src/github.com/scop/bash-completion/bash_completion ]] && . ~/src/github.com/scop/bash-completion/bash_completion

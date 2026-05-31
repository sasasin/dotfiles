# 文字化け対策
chcp.com 65001 > /dev/null

# macOS-like clipboard commands for Git Bash on Windows
pbcopy() {
  powershell.exe -NoProfile -Command '[Console]::InputEncoding = [System.Text.UTF8Encoding]::new(); $s = [Console]::In.ReadToEnd(); Set-Clipboard -Value $s'
}
pbpaste() {
  powershell.exe -NoProfile -Command '[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Get-Clipboard -Raw' | sed 's/\r$//'
}

# https://code.claude.com/docs/ja/setup
# Windows 上で実行可能な Git Bash へのパス
export CLAUDE_CODE_GIT_BASH_PATH=C:\\Users\\sasas\\scoop\\apps\\git\\current\\bin\\bash.exe
# Windows 上で実行可能な Git Bash へのパス
export OPENCODE_GIT_BASH_PATH=${CLAUDE_CODE_GIT_BASH_PATH}

# winsymlinks:native / winsymlinks:nativestrict は、
# MSYS2/Cygwin 系ランタイムに Windows ネイティブシンボリックリンクを作らせる設定です。
# nativestrict は、ネイティブシンボリックリンクを作れない場合に
# 黙って別方式へフォールバックせず失敗させます。
export MSYS=winsymlinks:nativestrict
# なお Windows 11 では一般ユーザーでシンボリックリンクを作成するには追加の権限が必要で、
# Windows 11 25h2 では [ 設定 > システム > 詳細設定 > 開発者モード ON ] で作成可能になる。

# _init_completion などを completion が利用している。
# Git for Windows の bash にバンドルされていない。
# bash-completion は winget や scoop で配布されていない。
# ghq get https://github.com/scop/bash-completion
# したものを source することにした
# macOS は homebrew で入手したものを利用する
[[ -f ~/src/github.com/scop/bash-completion/bash_completion ]] && . ~/src/github.com/scop/bash-completion/bash_completion

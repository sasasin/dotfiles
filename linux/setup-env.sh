#!/bin/bash -v
# --------------------------------------------------------------------
# パッケージインストール
# --------------------------------------------------------------------
# apt
sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y curl ripgrep
sudo apt install -y synaptic
sudo apt install -y ibus-skk skkdic skkdic-extra skktools skkdic-cdb
sudo apt install -y gnome-tweaks
sudo apt install -y starship
sudo apt install -y gh git git-delta git-filter-repo git-lfs
sudo apt install -y golang
sudo apt install -y rust-all
sudo apt install -y fzf
sudo apt install -y language-pack-gnome-ja language-pack-ja language-selector-gnome
sudo apt install -y libpython3-dev python3-dev

# --------------------------------------------------------------------
# snap
sudo snap install 1password
sudo snap install slack
sudo snap install gitkraken --classic
sudo snap install code --classic
sudo snap install brave
sudo snap install mise --classic
sudo snap install obsidian

# --------------------------------------------------------------------
# mise
# https://mise-tools.jdx.dev/ で探してインストールする
mise use -g ghq@latest
mise use -g atuin@latest
mise use -g kubectl@latest
mise use -g kubectx@latest
mise use -g uv@latest
mise use -g jq@latest
mise use -g sops@latest
mise use -g duckdb@latest
mise use -g helm@latest
mise use -g helmfile@latest
mise use -g minikube@latest
# https://github.com/zed-industries/zed/releases
mise use -g 'github:zed-industries/zed[prerelease=false,matching=linux-x86_64]@latest'
# https://github.com/anomalyco/opencode/releases
mise use -g 'github:anomalyco/opencode[matching=linux-x64]@latest'
# https://github.com/ggml-org/llama.cpp/releases
# llama.cpp は凝った指定が必要なので
mise use -g 'github:ggml-org/llama.cpp[version_prefix=b,prerelease=true,matching=ubuntu-rocm-10.0,minimum_release_age=0s]@latest'
# デバッグプリント
# mise ls-remote 'github:ggml-org/llama.cpp[version_prefix=b,prerelease=true]'
# --------------------------------------------------------------------
# そのほかツール類
# --------------------------------------------------------------------
# Grok Build
# https://github.com/xai-org/grok-build
curl -fsSL https://x.ai/cli/install.sh | bash

# --------------------------------------------------------------------
# そのほか設定
# --------------------------------------------------------------------
# Caps Lock キーを Ctrl キーとして使用するには
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
# --------------------------------------------------------------------
# 日本語フォルダ名を英語に改める
LANG=C xdg-user-dirs-update --force

# Snap 版 Firefox にフォントを認識させるには
# https://bugzilla.mozilla.org/show_bug.cgi?id=1760996&utm_source=chatgpt.com
# https://askubuntu.com/questions/1427695/how-to-make-snap-firefox-use-locally-installed-fonts
# ただし Firefox のバージョンアップすると再び状態が怪しくなるらしい。マジかよ...
mkdir -p ~/snap/firefox/current/.local/share
ln -s ~/.local/share/fonts ~/snap/firefox/current/.local/share/fonts
sudo fc-cache -f

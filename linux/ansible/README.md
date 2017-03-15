# What is this

Ubuntuをだいたいいい感じにセットアップする、シェルスクリプト & Ansibleです

# How to use

git cloneしてsudoでシェルスクリプト実行。パッケージアップデートも同様に実行すればOK。

```
sudo apt-get install -y git
git clone https://github.com/sasasin/dotfiles.git
cd dotfiles/linux/ansible
sudo ./provision.sh
sudo ./slowest_pkgs.sh
```

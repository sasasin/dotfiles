# dotfiles

Ubuntu、Macを、大体いい感じにセットアップするスクリプト集です。

#使い方

これを手元に持ってくるため、git-coreをインストールしてください。

    sudo apt-get update
    sudo apt-get install git-core

てきとうな場所にcloneして、セットアップスクリプトを実行します。

    mkdir $HOME/git
    cd $HOME/git
    git clone https://github.com/sasasin/dotfiles.git
    # for linux
    cd dotfiles/linux/ansible
    sudo ./provision.sh
    # for mac
    # xcodeをインストールしてから....
    cd dotfiles/mac/provision
    ./initial_setup.sh

# for macOS

https://github.com/sasasin/dotfiles を ZIP 形式でダウンロード

xcode, homebrew, Brewfile からのインストールをひととおり終えます。

```
% cd Download/dotfiles-master/mac/provision
% ./initial_setup.sh
```

github に ssh 接続を開通させる。

```
% eval "$(ssh-agent -s)"
Agent pid 16185
% ssh -T git@github.com
Hi sasasin! You've successfully authenticated, but GitHub does not provide shell access.
```

gh コマンドを開通させる。

```
% gh auth login
? What account do you want to log into? GitHub.com
? You're already logged into github.com. Do you want to re-authenticate? Yes
? What is your preferred protocol for Git operations? SSH
? Upload your SSH public key to your GitHub account? /Users/shinnosuke.suzuki/.ssh/id_rsa.pub
? Title for your SSH key: id_rsa.pub
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: XXXX-XXXX
Press Enter to open github.com in your browser... 
✓ Authentication complete.
- gh config set -h github.com git_protocol ssh
✓ Configured git protocol
HTTP 422: Validation Failed (https://api.github.com/user/keys)
key is already in use
```

ghq で dotfiles を手元に置く。いくつか dotfile を $HOME にシンボリックリンクを作る。

```
% ghq get git@github.com:sasasin/dotfiles.git
     clone ssh://git@github.com/sasasin/dotfiles.git -> /Users/shinnosuke.suzuki/src/github.com/sasasin/dotfiles
       git clone --recursive ssh://git@github.com/sasasin/dotfiles.git /Users/shinnosuke.suzuki/src/github.com/sasasin/dotfiles
Cloning into '/Users/shinnosuke.suzuki/src/github.com/sasasin/dotfiles'...
remote: Enumerating objects: 1863, done.
remote: Counting objects: 100% (550/550), done.
remote: Compressing objects: 100% (285/285), done.
remote: Total 1863 (delta 236), reused 499 (delta 214), pack-reused 1313
Receiving objects: 100% (1863/1863), 7.05 MiB | 4.80 MiB/s, done.
Resolving deltas: 100% (771/771), done.
% cd src/github.com/sasasin/dotfiles
% make_symlinks.sh
```

hyper ターミナルで諸々利用可能になります

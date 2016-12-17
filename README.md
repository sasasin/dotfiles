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

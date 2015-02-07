# dotfiles

Ubuntu/Xubuntu/Kubuntuを、大体いい感じにセットアップするスクリプト集です。

#使い方

これを手元に持ってくるため、git-coreをインストールしてください。

    sudo apt-get update
    sudo apt-get install git-core

てきとうな場所にcloneして、セットアップスクリプトを実行します。

    mkdir $HOME/git
    cd $HOME/git
    git clone https://github.com/sasasin/dotfiles.git
    cd dotfiles/script
    sudo ./startup.sh

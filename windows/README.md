# これは何

windows でいろいろ頑張るやつです

# バックアップする

choco で導入したもの

https://docs.chocolatey.org/en-us/choco/commands/export

```
choco export
```

winget で導入したもの

https://learn.microsoft.com/ja-jp/windows/package-manager/winget/export

```
winget export --output winget.export.json
```

VSCode。Settings sync now する。

# レストアする

windows 初回起動時は microsoft アカウントでローカルアカウントを作ってよい。

enpass を microsoft store からインストールする。パスワードマネージャーがないとどこにも入れないので。

https://github.com/sasasin/dotfiles を zip でダウンロードし、どこかに展開する。

windows update をとにかく全部適用する。

添付のセキュリティスイートを削除して、Windows Defenderで全部やらせる。

以下を実行する。windows terminalを管理者モードで起動して。

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

## wsl

wslをインストールする。windows terminalを管理者モードで起動して。

https://learn.microsoft.com/ja-jp/windows/wsl/install

```
wsl --install
```

## winget

winget をセットアップする。のだけど、最初から入ってることになってる。

https://learn.microsoft.com/ja-jp/windows/package-manager/winget/

winget で諸々レストアする

https://learn.microsoft.com/ja-jp/windows/package-manager/winget/import

```
winget import --import-file winget.export.json
```

## choco

choco コマンドの導入。windows terminalを管理者モードで起動して。

https://docs.chocolatey.org/en-us/choco/setup

choco コマンドで諸々レストアする。windows terminalを管理者モードで起動して。

https://docs.chocolatey.org/en-us/choco/commands/install

オプションなしに choco install することで、カレントディレクトリの packages.config に記載されたものを全部インストールやろうとする。

```
choco install
```

choco で gsudo が入れば、一般ユーザーのwindows terminalから

```
gsudo choco install .....
```

などとできるようになる。辛抱だ。

## VirtualBoxとWSL2を並存させる

「Windowsの機能の有効化または無効化」を開き、「Windows ハイパーバイザー プラットフォーム」にチェックをつける。

## Git Bash on Windows Terminal

windows terminal に Git Bash のプロファイルを作る。操作性やカラー、フォントなど windows terminal のガワを利用できるので。

* コマンドライン
    * `C:\Program Files\Git\bin\bash.exe`
* 開始ディレクトリ
    * `%USERPROFILE%`
* アイコン
    * `C:\Program Files\Git\mingw64\share\git\git-for-windows.ico`

Git Bash で $HOME に .bashrc を作る。シンボリックリンクどうにかしたい。

```
❯ cat .bashrc
export LANG=ja_JP.UTF-8

eval "$(starship init bash)"
```

## Starship at PowerShell

windows terminal の powershell に、starship を被せる。 $PROFILE が OneDrive を指してるなら、特に何もやることないはず。

```
❯ cat $PROFILE
Invoke-Expression (&starship init powershell)
```

## SSH key

GitHub の文書を眺めつつ生成、登録、確認する。

* https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
* https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
* https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection

Git Bash での手順なので、確認まで終えたら、PowerShellでも通るか確認する。

既に登録済のキーは整理してよい。

## GitKraken

SSH Keyの手順で生成したSSHキーを取り込む。

https://github.com/sasasin/dotfiles を zip でダウンロードし、どこかに展開した後、何かしら変更があれば、取り込んでGitHubにpushする。

# 参考

* https://learn.microsoft.com/ja-jp/windows/dev-environment/
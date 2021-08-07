# 概要 #

マインクラフト統合版サーバーをできるだけ簡単にインストールするスクリプト。  
マインクラフト統合版サーバー本体だけでなく、  

* マインクラフトサーバーをsystemctlで起動・停止する機能  
* Linux起動時に自動起動  
* 自動定期バックアップ機能  
* 自動アップデート機能  

がインストールできます(なお、これら機能はmiscriptsを使用しています)。  
なお、統合版サーバーをインストールするマシンと別マシンでこのスクリプトを動かすことを想定していますが、後述の通り同じマシンで実行しても構いません。  

統合版サーバーのインストール前に以下の規約やプライバシーポリシーに同意する必要があります。  
必ずチェックしてください。  

https://account.mojang.com/terms  
https://privacy.microsoft.com/ja-jp/privacystatement  

なお、このスクリプトはMinecraft公式のものではありません。    

# 想定環境 ##

## 統合版サーバーをインストールするマシン(以下A)

* Ubuntu 18以降
* WSL環境不可(v2含む)。

## このスクリプトを動かすマシン(以下B)

* UbuntuかDebian
* Aにssh接続可能であること

B→AへのSSH接続については  

* 公開鍵認証かつ.ssh/configに設定済み
* パスワード認証で.ssh/configは設定していない

のどちらかにしてください。また、sudoが使える一般ユーザーである必要があります。

ssh localhostが可能であれば、Aでこのスクリプトを実行しても構いません。  
なお、パスワード認証かつ.ssh/configを設定している場合は、.ssh/configの設定を使わないでください。   

# How To Use

以下の3通りのマインクラフト+管理機能のインストール方法があります。  

1. ansibleでinstall_server.ymlを実行してインストールする（確実だが面倒）  
2. install.shを実行してインストールする(普通)  
3. auto_install.shを使用してインストールする（一番楽）  

何も設定を変更しない場合サーバーのポートは19132としています（デフォルト値）。  
インストール後は、systemctl start mcbe@MCBEでサーバーの起動、systemctl stop mcbe@MCBEで停止ができます。  
また、定期バックアップは、/opt/MC/backup_dir/bedrock_backups/MCBE/以下に保存されます。  

最初の選択肢でインストールとアップデートが選べます。基本的なインストールには0を、mcscriptsのアップデートをする場合は1を選んでください。  
どちらも複数回実行して問題を起こすことはありませんので、途中で失敗したら再度実行してください。  

## 1の方法について

Bで対象ホストを自分で設定して、ansible-playbookコマンドでinstall-server.ymlを使用してください。 
example: ansible-playbook install_server.yml  

## 2の方法について

Bでinstall.shを実行してください（引数不要）。  
なお、インストールスクリプト内にはsudo必要な箇所とsudoでやってはいけない箇所があります(.ssh/configの都合)。  
そのため、上のコマンドはsudoで実行せず、一般ユーザーで実行してください。  

## 3の方法について

とにかく簡単にインストールする場合、Bで以下を実行してください。(git clone不要)    
wget http://www8.dodomore.tokyo/auto_install.sh && bash auto_install.sh    
install.shを自動的にダウンロードして実行します。  
こちらもsudoは使わないでください（途中でsudoパスワードを要求されます）。  

## 設定変更について

細かく設定を変更したい場合は2か3の方法を選択し、実行前にinstall_server.ymlのvarsを書き換えてください。  

- mc_home・・・Minecraftや各種管理サービスを動かすユーザーのホームディレクトリです
- backup_dir・・・Minecraftのデータのバックアップ先です。~mcはmc_homeです（デフォルト）。可能なら別のHDDを指定すると安全です。

他の項目は下の「同じマシンで複数のサーバーを動かす場合」を読んでください。  

# 2, 3の方法の実行中の入力項目について解説

実行中に分からなければ読んでください  

## 1. 統合版サーバーの・・・

省略  

## 2. このスクリプトの実行に必要な・・・

省略  

## 3. インストールするサーバーのIPもしくはドメインを入力

> インストールするサーバーのIPもしくはドメインを入力  
> （ssh/configを設定済みの場合はHostNameを入力）  

IPかドメイン名、もしくは.ssh/configで設定したHostNameを指定してEnterしてください。  

もし統合版サーバーをインストールする先のサーバー(A)のSSHポートを22以外にしていて、パスワード認証を使用する場合は、
ここでexample.com:1022のように:の後にポート番号を入れてください。  
公開鍵認証を使用する場合で、.ssh/configで設定している場合はここでポートの指定は不要です。    

## 4. インストール先サーバーでsudoにパスワード必要ですか

統合版サーバーをインストールするサーバー(A)のsudoパスワード有無  

> インストール先サーバーでsudoにパスワード必要ですか  
> はい: y  
> いいえ: nか何か  

sudo時にパスワード要求される場合は、y、不要な場合はnを入力してEnterしてください。  

## 5. SSHアクセス方法の選択  
> SSHアクセス方法の選択  
> 公開鍵認証でSSHログイン（.ssh/configを設定済み）: y  
> パスワード認証でSSHログイン: n  
> キャンセル: cか何か  

BからAへのSSH接続方法を選択してください。cの場合はキャンセルされて終了します。

## 6. ユーザー名入力(上でパスワード認証を選択した場合のみ)
> ユーザー名を入力してください  

インストールするサーバーにログインする際のユーザー名を入力してください。  
先述の通り、sudoが使える一般ユーザーである必要があります。  

## その他 
パスワード認証を選択した場合は  
> SSH password:  

が表示されます。SSH接続のパスワードを入力してください。    

sudoパスワードありの場合は  
> SUDO password[defaults to SSH password]:   

が表示されます。先程指定したユーザーのsudoパスワードを入力してください。  

# トラブルシューティング

fatal: [xx.xx.xx.xx]: FAILED! => {"msg": "Using a SSH password instead  of a key is not possible because Host Key checking is enabled and  sshpass does not support this.  Please add this host's fingerprint to  your known_hosts file to manage this host."}  
のようなエラーが起きた場合は、一度インストールするサーバーに手動でSSH接続できることを試してからやり直してください。

# 謝辞

Almost all functions of integrated-mcbeserv-system are provided by MCscripts.  
https://github.com/TapeWerm/MCscripts  
Thanks to TapeWerm for distributing good codes!  

# その他
もしgithubで報告できない内容は  
Twitter: @nanabach5  
にご連絡ください。  

公開リポジトリ作った経験は全然ですので、良い対応や早い対応は期待しないでください。  

# より詳細な使い方

## 資料
このインストールスクリプトはMCScriptsと統合版サーバーのインストールを自動化しているだけです。    
（MCscriptsのREADME通りの手順をansible playbook化しました）  
バックアップ、アプデなどの殆どの機能はMCscriptsを使っていますので、詳細については上の謝辞のリンク先のREADMEを読んでください。  
また、私の解説記事も書きました。  
https://animal-dengen.net/?p=971  

## 同じマシンで複数のサーバーを動かす場合

このスクリプトをgit cloneなどでダウンロードした後、install_server.ymlの  

* server_arg: "MCBE"  
* mc_port: 19132  

の部分を既に作成しているサーバーとかぶらないように書き換えてから、install.shを実行してください。
同じことを繰り返せば多分何個でもいけると思います。  
server_argsに対応したサービスとディレクトリが新たに作成されます。  
例：server_argをMCBE2にした場合、  

* サービスmcbe@MCBE2.service  
* サービスmbbe@MCBE2.socket  
* ・・・  
* サーバーディレクトリ/opt/MC/bedrock/MCBE2  
* バックアップディレクトリ/opt/MC/backup_dir/bedrock_backups/MCBE2  

などが作成されます。  
なぜかたまに失敗するので、その場合はserver_argの付いたサービスをすべてstop, disableし、サーバーディレクトリを削除してマシンを再起動してからやり直してください。  

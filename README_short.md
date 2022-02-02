# 概要 #
以下の4つのファイルの使い方の紹介です。

1. ***統合版マインクラフトとMcscriptsのインストール用playbook(install_server.yml)***  
2. Mcscriptsのアップデート用playbook(update_mcscripts.yml)  
3. バックアップしたワールドデータ(zipファイル)のサーバーへのデプロイスクリプト(world_to_server.sh)
4. 現在のワールドのダウンロードスクリプト(world_to_local.sh)

2~4は1がインストールされていることを前提としています。

統合版サーバーのインストール前に以下の規約やプライバシーポリシーに同意する必要があります。  
必ずチェックしてください。  

https://account.mojang.com/terms  
https://privacy.microsoft.com/ja-jp/privacystatement  

# 動作環境（インストールされるサーバー） ##

* Ubuntu 18以降
* WSL環境は不可(WSL2含む)。Dockerも不可。それ以外なら大丈夫。

# 各ファイルの使い方

## 統合版マインクラフトとMcscriptsのインストール(install_server.yml)

### 概要  
統合版マインクラフトサーバーをインストールし、さらに追加で以下の機能をインストールします。  

- マインクラフトサーバーのservice化
- マインクラフトサーバーのワールドデータの定期バックアップ
- マインクラフトサーバーの自動アップデート

なお、これら機能はhttps://github.com/TapeWerm/MCscripts を使用しています。

### configuration
必要あればplaybook内の以下の項目をインストール前に変更してください。特に変えずとも動きます。  

- backup_dir・・・Minecraftのワールドデータの定期バックアップ先です。~mcはmc_homeです。可能であれば故障に備えてサーバー本体のHDDとは別のHDDのディレクトリを指定してください。  
- server_arg・・・各サービスのpostfixおよび、サーバーのディレクトリ名です。もし一台のマシンで複数のマインクラフトサーバーを動かす場合は別の文字列を指定して実行してください。  
- mc_port・・・マインクラフトサーバーのポートです。もし一台のマシンで複数のマインクラフトサーバーを動かす場合は別のポートを指定して実行してください。  

### インストール後の各機能の操作について

Mcscriptsの情報を参照してください。  
https://github.com/TapeWerm/MCscripts/  

基本操作  
- サーバーの起動・停止: systemctl start/stop mcbe@MCBE.service  
- バックアップ即時実行: systemctl start mcbe-backup@MCBE.service  

## Mcscriptsのアップデート(update_mcscripts.yml)  

### 概要

Mcscriptsのアップデートを行います。  
マインクラフトサーバーの配布ページの仕様変更などでMcscriptsが動かなくなることがあり、それに対応したアップデートがあった際はこれでアップデートできます。  

### configuration

上のマインクラフトサーバーとMcscriptsのインストールと同じです。 変更している場合はこちらのmc_homeやserver_argも書き換えてください。   

## バックアップしたワールドデータのサーバーへのデプロイスクリプト(world_to_server.yml)

### 概要 
Mcscriptsでバックアップされたワールドデータのzip（ローカルに存在）をサーバーにデプロイするスクリプトです。  
を実行して、サーバー上で現在稼働中のワールドデータをバックアップしてからサーバーデータをコピーしてください（下記のbackupの項目で変更可能）。 

### configuration

- zip_file: ローカルのワールドデータzipのパスを指定
- backup: 現在のサーバーで動いているワールドデータをバックアップするか否か(バックアップにはmcbe-backup@.serviceを使用)

その他は上のインストールのconfigurationと同じです。変更している場合はこちらのmc_homeやserver_argも書き換えてください。  

## 現在のワールドのダウンロードスクリプト(world_to_local.sh)

### 概要
注：これだけシェルスクリプトです

現在サーバーで動いているワールドデータをダウンロードします。

### 使い方

bash world_to_local.sh (Hostname)  

Hostnameの部分は.ssh/configで設定済みであること  

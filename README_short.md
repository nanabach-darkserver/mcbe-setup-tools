# 概要 #

1. 統合版マインクラフトとMcscriptsのインストール用playbook(install_server.yml)  
2. Mcscriptsのアップデート用playbook(update_mcscripts.yml)  
3. バックアップしたワールドデータ(zipファイル)のサーバーへのデプロイスクリプト(world_to_server.sh)
4. 現在のワールドのダウンロードスクリプト(world_to_local.sh)

統合版サーバーのインストール前に以下の規約やプライバシーポリシーに同意する必要があります。  
必ずチェックしてください。  

https://account.mojang.com/terms  
https://privacy.microsoft.com/ja-jp/privacystatement  

# 動作環境（インストールされるサーバー） ##

* Ubuntu 18以降
* WSL環境不可(v2含む)。

# How To Use

## 統合版マインクラフトとMcscriptsのインストール(install_server.yml)

### 概要  
統合版マインクラフトサーバーをインストールし、さらに追加で以下の機能をインストールします。  

- マインクラフトサーバーのservice化
- マインクラフトサーバーのワールドデータの定期バックアップ
- マインクラフトサーバーの自動アップデート

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
mcbe-backup@.serviceを実行してバックアップしてからサーバーデータをコピーします（下記のbackupの項目で変更可能）。  

### configuration

- zip_file: ローカルのワールドデータzipのパスを指定
- backup: 現在のサーバーで動いているワールドデータをバックアップするか否か

その他は上のインストールのconfigurationと同じです。変更している場合はこちらのmc_homeやserver_argも書き換えてください。  

## 現在のワールドのダウンロードスクリプト(world_to_local.sh)

### 概要
注：これだけシェルスクリプトです

現在サーバーで動いているワールドデータをダウンロードします。

### 使い方

bash world_to_local.sh (Hostname)  

Hostnameの部分は.ssh/configで設定済みであること  
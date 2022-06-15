# はじめに

MCscripts導入済みのサーバーへworldデータをアップロード/ダウンロードするツール  

# 想定環境 #

MCscriptsのインストールがすでに完了しているサーバー  
以下2つどちらも実行前にmcbe@.serviceは停止しておいてください。  

# world_to_server.yml #

## 概要

ローカルのworldデータのzipをMCscriptsを導入済みのサーバーのworldデータのディレクトリにアップロードするansible playbook  

対象サーバーへは.ssh/configで設定済みで、HostNameでsshできること、またsudoでパスワードは要求されない状態であることを想定。そうでない場合はplaybookの変更や実行コマンドの変更が必要。

## 設定項目

1. MCscriptsで複数サーバーを立ち上げるなどして、サービス名がmcbe@MCBE.service以外になっている場合は、varsのserver_argをMCBEから変えてください。  
2. zip_fileはアップロードするzipファイルのパスに書き換えてください。  
3. backupがtrueなら現在のサーバー上のworldデータ(~mc/bedrock/MCBE/worlds/Bedrock level)を削除する前にmcbe-backup@.serviceでバックアップを実行する。falseならバックアップしない。

## 実行  

ansible-playbook world_to_server.yml

# world_to_local.sh #

## 設定項目

MCscriptsで複数サーバーを立ち上げるなどして、サービス名がmcbe@MCBE.service以外になっている場合は、スクリプト最初のserver_argをMCBEから変えてください。  
対象サーバーへは.ssh/configで設定済みで、HostNameでsshできることが前提。  

## 実行

bash world_to_local.sh (.ssh/configで設定したHostName)

# 共通項目 #

以上でアップロード及びダウンロードされるzipファイルは、linuxのunzipコマンドで解凍すると、Bedlock levelのディレクトリが同じ階層にできるような階層構造です。

以下解凍イメージ
<pre>
xxxxxx@DESKTOP-BUNMQ23:~/mcbe-setup-tools/downloads$ ls
 202206152136.zip
xxxxxx@DESKTOP-BUNMQ23:~/mcbe-setup-tools/downloads$ unzip 202206152136.zip 
Archive:  202206152136.zip
   creating: Bedrock level/
   creating: Bedrock level/db/
（省略）
xxxxxx@DESKTOP-BUNMQ23:~/mcbe-setup-tools/downloads$ ls
 202206152136.zip  'Bedrock level'
</pre>


# その他

元々インストールスクリプトなどを含んでいましたが、MCscriptsのインストールスクリプトが整備されたので削除しました。  
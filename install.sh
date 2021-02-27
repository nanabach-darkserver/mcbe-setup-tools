echo "必要ソフトウェアをインストールします"
apt install ansible sshpass

echo "インストールするサーバーには公開鍵認証を設定済みかつ、.ssh/configを設定済みですか"
echo "はい→y"
echo "いいえ→n"
read is_pka

echo "インストールするサーバーのIPもしくはドメインを入力"
echo "（ssh/configを設定済みの場合はHostNameを入力）"
read mcsrv_host

echo '[mcbe_hosts]' > ./

echo "インストール先サーバーでsudoにパスワード必要ですか"
echo "はい→y"
echo "いいえ→n"

if [[ $is_pka = 'y' ]];then
    

# もしrootユーザーでSSH可能な場合

#


echo "必要ソフトウェアをインストールします"
sudo apt install ansible sshpass

echo '-----------------------------------------'
echo "インストールするサーバーのIPもしくはドメインを入力"
echo "（ssh/configを設定済みの場合はHostNameを入力）"
read mcsrv_host
echo

# hostsファイルを作成
echo '[mcbe_hosts]' > ./mcbe_hosts
echo "${mcsrv_host}" >> ./mcbe_hosts

echo "インストール先サーバーでsudoにパスワード必要ですか"
echo "はい: y"
echo "いいえ: nか何か"
read is_sudopass
echo

# sudoパスワード入力の有無
sudopass_option=''
if [[ $is_sudopass = 'y' ]]; then
    sudopass_option='--ask-sudo-pass'
fi

echo "インストールするサーバーには公開鍵認証を設定済みかつ、.ssh/configを設定済み: y"
echo ".ssh/config未設定でパスワード認証: n"
echo "それ以外には対応していません。キャンセル: cか何か"
read is_pka
echo


if [[ $is_pka = 'y' ]]; then
    ansible-playbook ${sudopass_option} -i ./mcbe_hosts install_server.yml
    echo "failedが0なら成功です。unreachableが0でない場合はユーザー名やホスト名、パスワードが間違えています"
elif [[ $is_pka = 'n' ]]; then
    echo 'ユーザー名を入力してください'
    read login_username
    ansible-playbook -i ./mcbe_hosts -u ${login_username} -k install_server.yml ${sudopass_option}
    echo "failedが0なら成功です。unreachableが0でない場合はユーザー名やホスト名、パスワードが間違えています"
else
    echo "キャンセルしました"
fi


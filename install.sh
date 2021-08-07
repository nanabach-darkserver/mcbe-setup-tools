echo '-----------------------------------------'
echo '新規インストールなら0, アップデートなら1を入力'
read is_update

if [[ $is_update == '0' ]]; then
    playbook='install_server.yml'
elif [[ $is_update == '1' ]]; then
    playbook='update_mcscripts.yml'
else
    exit 0
fi

echo '-----------------------------------------'
echo "1. 統合版サーバーのインストール前に以下の規約やプライバシーポリシーに同意する必要があります。"
echo "https://account.mojang.com/terms"
echo "https://privacy.microsoft.com/ja-jp/privacystatement"
echo
echo "同意しますか: y/n"
echo "(中断して規約を確認する場合は、nを入力)" 
read is_agree

if [[ $is_agree != 'y' ]]; then
    exit 0
fi

echo '-----------------------------------------'
echo "2. このスクリプトの実行に必要ソフトウェアをインストールします"
echo "（ここでpasswordを要求された場合は、このスクリプトを実行中のマシンのpasswordです（ここだけ））"
sudo apt install sshpass python3-pip
sudo pip3 install ansible

echo '-----------------------------------------'
echo "3. インストールするサーバーのIPもしくはドメインを入力"
echo "（.ssh/configで公開鍵認証を設定済みの場合はHostNameを入力）"
read mcsrv_host
echo

# hostsファイルを作成
echo '[mcbe_hosts]' > ./mcbe_hosts
echo "${mcsrv_host}" >> ./mcbe_hosts

echo '-----------------------------------------'
echo "4. インストール先サーバーでsudoにパスワード必要ですか"
echo "はい: y"
echo "いいえ: nか何か"
read is_sudopass

# sudoパスワード入力の有無
sudopass_option=''
if [[ $is_sudopass = 'y' ]]; then
    sudopass_option='--ask-become-pass'
fi

echo '-----------------------------------------'
echo "5. SSHアクセス方法の選択"
echo "公開鍵認証でSSHログイン（.ssh/configを設定済み）: y"
echo ".ssh/config未設定でパスワード認証: n"
echo "キャンセル: cか何か"
read is_pka
echo

if [[ $is_pka = 'y' ]]; then
    ansible-playbook -i ./mcbe_hosts ${sudopass_option} ${playbook}
    echo '-----------------------------------------'
    echo "failedが0なら成功です。unreachableが0でない場合はユーザー名やホスト名、パスワードが間違えています"
elif [[ $is_pka = 'n' ]]; then
    echo '6. ユーザー名を入力してください'
    read login_username
    ansible-playbook  -i ./mcbe_hosts -u ${login_username} -k ${sudopass_option} ${playbook}
    echo '-----------------------------------------'
    echo "failedが0なら成功です。unreachableが0でない場合はユーザー名やホスト名、パスワードが間違えています"
else
    echo '-----------------------------------------'
    echo "キャンセルしました"
fi


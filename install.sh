USER_NAME="あなたのユーザー名"

apt install ansible

# 
ansible-playbook install_server.yml -k --ask-become-pass

ftp_server=`cat ./remote_backup.sh | grep -E '^SERVER_FTP=.*$' | sed -s `

if [ ${ftp_server} == 'ftp.example.com' ]; then
    echo "リモートバックアップ先ホストは設定されていません。"
    echo "リモートバックアップのセットアップはスキップします。"
else
    ansible-playbook 

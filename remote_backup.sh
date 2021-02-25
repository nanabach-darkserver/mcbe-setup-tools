#!/bin/bash

# バックアップ先FTPサーバーのURLかIP
SERVER_FTP="ftp.example.com"

# バックアップ先FTPサーバーのバックアップ先フォルダのパス
REMOTE_DIR=mc_backup/

# バックアップ元マイクラサーバーのバックアップディレクトリ。
# install_server.ymlのバックアップ先ディレクトリをいじっていなければ変更不要。
LOCAL_DIR=~mc/bedrock/MCBE_Backups/Bedrock\ level_Backups

# ftpサーバーにログインする用のユーザーネーム
USER=your_user_name
# FTPサーバーにログインする用のパスワード
PASS=password

/usr/bin/lftp <<END
open -u ${USER},${PASS} ftp://${SERVER_FTP}
mirror -R "${LOCAL_DIR}"  ${REMOTE_DIR}
quit
END

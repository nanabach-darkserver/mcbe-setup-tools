#!/bin/bash

# ftp server URL or IP
SERVER_FTP="ftp.example.com"

# path of ftp backup dir(destination remote server)
REMOTE_DIR=mc_backup/

# Path of mcbe backup dir(mcbe server)
# You don't need to change this path unless you change backup dir path in ansbile playbook.
LOCAL_DIR=~mc/bedrock/MCBE_Backups/Bedrock\ level_Backups

# user name to login ftp server
USER=your_user_name
# pass to login ftp server
PASS=password

/usr/bin/lftp <<END
open -u ${USER},${PASS} ftp://${SERVER_FTP}
mirror -R "${LOCAL_DIR}"  ${REMOTE_DIR}
quit
END

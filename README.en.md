# Overview

Playbooks for
- installing Minecraft Bedrock Edition server and mcscripts.  
- update mcscripts

About mcscripts: https://github.com/TapeWerm/MCscripts   

# About files

- install_server.yml: Install Minecraft Bedrock edition and mcscripts
- update_mcscripts.yml: Updating mcscripts.

For some reason, only this README file and above playbooks are in Englist.  

# Requirements

- Ubuntu 18.04 or 20.04
- you can ssh by general user which can use sudo

# Configration of playbooks 

- hosts: Hosts to install
- mc_home: Home directory of user 'mc'(Execution user of Minecraft Server)
- backup_dir: Directry to backup world data
- server_arg: Postfix of server services and name of server data direcroty. 
- mc_port: Minecraft server port.

# If you want to run multiple Minecraft Server

You can run multiple Minecraft servers by changing server_arg and mc_port and execute playbook.
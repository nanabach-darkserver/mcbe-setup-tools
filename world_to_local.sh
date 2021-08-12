set -eu

mc_home='/opt/MC'
server_arg='MCBE'

if [ $# != 1 ]; then
  echo 'arguments error'
  exit 1
fi

mkdir -p ./tmp
rm -rf ./tmp/*

mkdir -p ./downloads

scp -r "${1}:${mc_home}/bedrock/${server_arg}/worlds/Bedrock\ level/" ./tmp/

zip_name=`date +%Y%m%d%H%M`.zip
cd tmp;
zip "../downloads/${zip_name}" -r 'Bedrock level' && echo -e "\nworld data saved as downloads/${zip_name}" 
cd ../
echo

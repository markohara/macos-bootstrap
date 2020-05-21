scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/../formatter.sh

echo "Configuring chisel"
touch ~/.lldbinit
echo "command script import /usr/local/opt/chisel/libexec/fbchisellldb.py" >> ~/.lldbinit
echoSuccess "Chisel configured"
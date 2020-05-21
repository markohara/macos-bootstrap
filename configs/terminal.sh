scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/../formatter.sh

echo "Configuring terminal"
./~/Documents/repos/iterm-config/configure.sh
echoSuccess "terminal configured"
scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/../formatter.sh

echo "Setting dock autohide (accept system prompt)"
osascript ./$scriptDir/autohideDock.scpt
echoSuccess "Dock set to autohide"
scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. $scriptDir/../formatter.sh

echo "Setting darkmode (accept system prompt)"
osascript ./$scriptDir/setDarkmode.scpt
echoSuccess "Darkmode set"
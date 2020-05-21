scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/../formatter.sh

echo "Enabling battery percentage"
defaults write com.apple.menuextra.battery ShowPercent YES
killall SystemUIServer
echoSuccess "Battery percentage enabled"
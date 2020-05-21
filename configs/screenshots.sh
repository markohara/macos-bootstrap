scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/../formatter.sh

echo "Changing screenshot directory"
mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
echoSuccess "Screenshots directory moved to ~/Documents/Screenshots"

#!/usr/bin/env bash
scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/lib.sh
. ${scriptDir}/components.sh

configureFlags "$@"

  echo "
    ${green}

        ██████╗  ██████╗  ██████╗ ████████╗███████╗████████╗██████╗  █████╗ ██████╗ 
        ██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
        ██████╔╝██║   ██║██║   ██║   ██║   ███████╗   ██║   ██████╔╝███████║██████╔╝
        ██╔══██╗██║   ██║██║   ██║   ██║   ╚════██║   ██║   ██╔══██╗██╔══██║██╔═══╝ 
        ██████╔╝╚██████╔╝╚██████╔╝   ██║   ███████║   ██║   ██║  ██║██║  ██║██║     
        ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     

                            - - - MacOS bootstrap Script - - -
    ${normal}

This script will configure MacOS machines with my perferred applications,
Throughout you will be prompted for input so keep your 👀 on it.
${bold}To learn more run the script with the -h flag.${normal}
"
echoWarning "if you terminate the script early or something goes wrong run cleanup.sh!"; echo

holdStep "When you're ready"

##############################
########## REQUIRED ##########
##############################

# ---- Capture required details ----
captureXcodeAccountDetails

echoInfo "In order to download apps from the App Store you must be logged in,
check to make sure you are then come back"; echo

open -a "App Store"
holdStep "Please log into the Mac App Store, it has been opened for you"
killall "App Store"

# ---- Configure SSH key ----
if [ -f "~/.ssh/id_rsa.pub" ]; then
    echo "Creating an SSH key"

    local email=$(captureUsername "Enter the email for which you want the SSH key: ")
    ssh-keygen -t rsa -b 4096 -C "$email"
    echo "SSH Key created for email $email"
    else 
    echo "Existing ssh key found"
fi

key=$(cat ~/.ssh/id_rsa.pub)
toClipboard "Public key" $key
holdStep "Add this public key to your github account https://github.com"

echoSuccess "SSH Key configured"

# ---- Install Homebrew ----
which -s brew
if [ $? != 0 ]; then
    echo "Installing Homebrew..."
    installBrew $BREW_URL
fi

echoSuccess "Homebrew Installed"

# ---- Install Ruby ----
installRuby

# ---- Install required brew packages ----
brewInstall false "${requiredBrewPkgs[@]}"

# ---- Clone required git repos ----
gitClone false "${requiredRepos[@]}"

# ---- Install required gems ----
gemInstall false "${requiredGems[@]}"

# --- Install required App Store Apps ----
appStoreInstall false "${requiredAppStoreApps[@]}"

# ---- Install Xcode ----
installedVersions=$(xcversion installed | grep $XCODE_VERSION)
if [ $? -ne 0 ]; then
    echo "Installing Xcode $XCODE_VERSION ..."
    xcversion install "$XCODE_VERSION"
fi
echoSuccess "Xcode $XCODE_VERSION Installed"

###############################
########## OPTIONAL? ##########
###############################

# ---- Install brew packages ----
brewInstall true "${optionalBrewPkgs[@]}"

# ---- Install brew cask packages ----
brewCaskInstall true "${optionalBrewCaskPkgs[@]}"

# ---- Clone git repos ----
gitClone true "${optionalRepos[@]}"

# ---- Install App Store apps ----
appStoreInstall true "${optionalAppStoreApps[@]}"

./configs/run.sh

./cleanup.sh

echo; echo ${bold}"All Done! 🎉 your machine has been bootstraped"${normal}; echo

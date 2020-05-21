#!/usr/bin/env bash
scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/formatter.sh
. ${scriptDir}/man.sh

function configureFlags {
    for arg in "$1"
    do
        case $arg in
            -h|--help)
                helpmenu
                exit
            ;;
            -y)
            export BOOTSTRAP_ALL="YES"
            ;;
        esac
        shift
    done
}

function installRuby {
    if [[ ! -e $HOME/.rvm ]]; then
        echo "Installing RVM and Ruby ..."
        curl -sSL https://get.rvm.io | bash -s stable
        source ~/.rvm/scripts/rvm
        rvm install ruby-head
    fi

    echoSuccess "RVM and Ruby Installed"
}

function promptForInstall {
    if [ ! -z "$BOOTSTRAP_ALL" ]; then
        true
    else
        prompt="Would you like $1 to be installed? [Y/N] "
        
        read -r -p "$prompt" res
        
        case $res in
            [yY])
                true
            ;;
            *)
                false
            ;;
        esac
    fi
}

function promptForClone {
    echo "inside"
    if [ ! -z "$BOOTSTRAP_ALL" ]; then
        echo "hi"
        true
    else
        prompt="Would you like $1 to be cloned? [Y/N] "
        
        read -r -p "$prompt" res
        
        case $res in
            [yY])
                true
            ;;
            *)
                false
            ;;
        esac
    fi
}

function installedViaBrew {
    if brew list -1 | grep -q "$1"; then
        echoSuccess "$1 is installed"
        true
    else
        false
    fi
}

function installedViaGem {
    if gem list --local | grep -q "$1"; then
        echoSuccess "$1 is installed"
        true
    else
        false
    fi
}

function isApplicationInstalled {
    if [ -d "/Applications/$1" ]; then
        echoSuccess "$1 is installed"
        true
    else
        false
    fi
}

function installBrew {
    echoInfo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL $1)"
    echoSuccess "Homebrew Installed"
}

function brewInstall {
    local shouldPrompt=$1; shift
    brewCaskPkgs=("$@")

    for pkg in ${brewCaskPkgs[@]}
    do
        if installedViaBrew $pkg; then
            continue
        fi
        
        if test -z "$2"; then
            if promptForInstall "$pkg" == false; then
                continue
            fi
        fi
        
        echo "Installing $pkg..."
        brew install $pkg
        echoSuccess "$pkg Installed"

    done
}

function brewCaskInstall {
    local shouldPrompt=$1; shift
    brewCaskPkgs=("$@")

    IFS=""
    for rpkg in ${brewCaskPkgs[@]}
    do
        IFS=";" read -r -a pkg <<< "${rpkg}"
        pkgName="${pkg[0]}"; appName="${pkg[1]}"

        #Making sure the application wasnt installed outside of homebrew
        if isApplicationInstalled "$appName.app"; then
            continue
        fi

        if $shouldPrompt || $BOOTSTRAP_ALL; then
            promptForInstall "$appName"
            if [ $? == 1 ]; then
                continue
            fi
        fi

        echo "Installing $appName..."
        brew cask install "$pkgName"
        echoSuccess "$appName Installed"
    done
}

function gemInstall {
    local shouldPrompt=$1; shift
    gems=("$@")

    for gem in ${gems[@]}
    do
        if installedViaGem $gem; then
            continue
        fi

        if $shouldPrompt || $BOOTSTRAP_ALL; then
            promptForInstall "$gem"
            if [ $? == 1 ]; then
                continue
            fi
        fi

        echo "Installing $gem..."
        sudo gem install "$gem"
        echo "$gem Installed"
    done
}

function appStoreInstall {
    local shouldPrompt=$1; shift

    appStoreApps=("$@")

    for rapp in "${appStoreApps[@]}"
    do
        IFS=";" read -r -a app <<< "${rapp}"
        appID="${app[0]}"; appName="${app[1]}"

        # Making sure the application wasnt installed outside of homebrew
        if isApplicationInstalled "$appName.app"; then
            continue
        fi

        if $shouldPrompt || $BOOTSTRAP_ALL; then
            promptForInstall "$appName"
            if [ $? == 1 ]; then
                continue
            fi
        fi

        echo "Installing $appName..."
        sudo mas install $appID
        echoSuccess "$appName Installed"

    done
}

# Clones an array of github repos
function gitClone {
    local shouldPrompt=$1; shift
    repos=("$@")

    scriptDir=$PWD
    mkdir -p ~/Documents/repos
    cd ~/Documents/repos

    for rrepo in "${repos[@]}"
    do
        IFS=";" read -r -a repo <<< "${rrepo}"
        user=${repo[0]}; rname=${repo[1]}

        # Making sure the repo wasnt clone before
        if ls | grep -q "$rname"; then
            echoSuccess "$rname already cloned"
            continue
        fi

        if $shouldPrompt || $BOOTSTRAP_ALL; then
            promptForInstall "$rname"
            if [ $? == 1 ]; then
                continue
            fi
        fi

        echo "cloning $rname..."
        git clone "git@github.com:$user/$rname.git"
        echoSuccess "$rname cloned"
    done

    cd $scriptDir
}

# pipes content to clipboard
# $1 - Name of content
# $2 - The content
function toClipboard {
    echo $2 | pbcopy
    echoClip "$1"
}

function captureUsername {
    read -r -p "$1" username
    echo $username
}

function capturePassword {
    read -r -s -p "$1" password
    echo $password
}

function captureXcodeAccountDetails {
    echoInfo "In order to install Xcode you will have to provide your developer account details;"
    echo

    prompt="Please enter your Apple Developer ID"

    local user=$(captureUsername "$prompt: ")
    export XCODE_INSTALL_USER=$user

    local pass=$(capturePassword "$prompt password: ")
    export XCODE_INSTALL_PASSWORD=$pass
    echo
    echo
}

function holdStep {
    read -r -p "$1, press any key to continue :"
    echo
}
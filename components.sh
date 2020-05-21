#!/usr/bin/env bash

BREW_URL="https://raw.githubusercontent.com/Homebrew/install/master/install"
XCODE_VERSION="11.4"

# These required packages are used to install other optional packages
requiredBrewPkgs=(
    "mas" #Commandline client for the Mac App Store
)

requiredGems=(
    "xcode-install"
)

#Values are the github user and the repo name seperated by ;
requiredRepos=(
    "markohara;iterm-config" #Iterm config repo
)

#Values are the app ID and the app name seperated by ;
#omit the .app extension
requiredAppStoreApps=(
)

#Optional packages/ applications
optionalBrewPkgs=(
    "hub" #Commandline client for github
    "chisel" #LLDB tool for debugging ios apps
)

#Values are the brew package name and the app name seperated by ;
#omit the .app extension
optionalBrewCaskPkgs=(
    "google-chrome;Google Chrome" #Google Chrome
    "iterm2;iTerm" #iTerm Terminal
    "spotify;Spotify" #Spotify
    "db-browser-for-sqlite;DB Browser for SQLite"
    "lastpass;LastPass" #Password Manager
    "visual-studio-code;Visual Studio Code" #VSCode
    "spark;Spark" #Spark email client
    "insomnia;Insomnia" #Insomnia rest client
    "sketch;Sketch" 
    "macdown;MacDown" #MarkDown editor
)

#Values are the app ID and the app name seperated by ;
#omit the .app extension
optionalAppStoreApps=(
    "441258766;Magnet" #Magnet, macos window manager
)

#Values are the github user and the repo name seperated by ;
optionalRepos=(
)
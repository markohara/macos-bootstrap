#!/usr/bin/env bash

# Styling functionality

bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)

function echoInfo {
    echo "ℹ️  $1"
}

function echoClip {
    echo "✂️  $1 copied to clipboard"
    echo
}

function echoSuccess {
    echo "✅ ${green}$1${normal}"
}

function echoWarning {
    echo "⚠️  ${bold}$1${normal} ⚠️"
}
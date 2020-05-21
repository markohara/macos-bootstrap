#!/usr/bin/env bash
scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/formatter.sh

function helpmenu {
    echo "
    ${bold}NAME${normal}
        MacOS-Bootstrap -- Bootstrap MacOS machines effortlessly

    ${bold}SYNOPIS${normal}
        ./install.sh ${bold}[-y]${normal}
        ./install.sh ${bold}[-h | --help]${normal}

    ${bold}DESCRIPTION${normal}
        This script allows you to provision a MacOS machine with my preferences. If you would like to use this script
        it should only require you to modify the components.sh file. The components.sh file holds the details of all
        the software and packages which it will install.

        Configs, configs are small additional tweaks which will perform additional set up for packages/software and 
        make small changes to MacOS itself.

        ${bold}-y${normal}  The y flag will automatically say yes to any prompts for install, you will still need to
        input some required details such as log in details and system passwords throughout.

        ${bold}-h --help${normal}   The h or help flag will show this man style page.
    "
}
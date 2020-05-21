#!/usr/bin/env bash
scriptDir="$(dirname "${BASH_SOURCE[0]}")"
. ${scriptDir}/../formatter.sh

echo; echo ${bold} "Running configuration scripts" ${normal}; echo

##### CONFIGURE APPLICATIONS/ UTILITIES #####
./$scriptDir/chisel.sh
./$scriptDir/terminal.sh

##### CONFIGURE MACOS #####
./$scriptDir/darkmode.sh
./$scriptDir/dock.sh
./$scriptDir/battery.sh
./$scriptDir/screenshots.sh

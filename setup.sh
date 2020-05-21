#!/usr/bin/env bash

cd ~/Documents
git clone git@github.com:markohara/macos-bootstrap.git
cd macos-bootstrap
./install.sh $@
rm-rf ~/Documents/macos-bootstrap
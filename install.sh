#!/bin/bash

set -e

echo
echo "Installing dependencies"
sudo apt install git curl jq

echo
echo "Creating inslataion directory"
rm -rf ~/.gh-update
mkdir ~/.gh-update

echo
echo "Downloading ..."
git clone https://github.com/LeoFalco/gh-update ~/.gh-update

echo
echo "Granting run permission"
sudo chmod +x ~/.gh-update/gh-update.sh

echo
echo "Instalation done"
echo "to make gh-update command available on any directory"
echo "add theese lines to your .bash_profile or .zshrc or similar"
echo
echo "alias gh-update=~/.gh-update/gh-update.sh"

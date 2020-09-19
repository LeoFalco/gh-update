#!/bin/bash

set -e

echo "Hello $USER"

rm -rf ~/.gh-update/out
mkdir  ~/.gh-update/out

echo "Searcing for github cli updates ..."

last_release=$(curl "https://api.github.com/repos/cli/cli/releases?per_page=1&page=1" -fsS)

download_url=$(echo $last_release | \
    jq '.[0].assets[].browser_download_url' | \
    grep amd64.deb | \
    cut -d'"' -f2
)

latest_version=$(echo $download_url | cut -d'/' -f8)
current_version=$(gh --version 2>/dev/null | grep tag | cut -d'/' -f8)


if [ -z "$current_version" ]; then
    current_version="not installed"
fi


if [ "$current_version" = "$latest_version" ]; then
    echo "All done github already updated!"
    exit 0
fi

echo "Current version : $current_version"
echo "Latest version  : $latest_version"
echo "New version found, lets update it!"
echo "Fazendo download..."
curl $download_url -fL -o  ~/.gh-update/out/gh_latest.deb

echo "Installing..."

sudo dpkg -i  ~/.gh-update/out/gh_latest.deb

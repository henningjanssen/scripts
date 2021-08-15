#!/usr/bin/env bash
set -e

# Ask for the key-file
read -p "File to store the key in: " kf

# Generate key
# The corresponding e-mail-address is passed as the first parameter
ssh-keygen -t rsa -b 4096 -C "$1" -f $kf

# start the ssh-agent in the background
eval "$(ssh-agent -s)"

# add the key
ssh-add $kf

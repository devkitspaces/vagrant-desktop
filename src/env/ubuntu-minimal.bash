#!/bin/bash
echo "Installing the minimal ubuntu desktop environment, this may take a little bit." 1>&3

echo "Installing ubuntu-desktop..." 1>&3
apt-get -y install --no-install-recommends ubuntu-desktop

echo "Installing unity..." 1>&3
apt-get -y install --install-recommends unity indicator-session

echo "Installing essentials..." 1>&3
apt-get -y install gnome-terminal
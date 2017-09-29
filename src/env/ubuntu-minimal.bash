#!/bin/bash
echo "Installing the minimal ubuntu-desktop, this may take a little bit."
apt-get -y install --no-install-recommends ubuntu-desktop
apt-get -y install --install-recommends unity indicator-session
apt-get -y install gnome-terminal
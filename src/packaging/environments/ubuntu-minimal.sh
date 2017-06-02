#!/bin/bash
start="$(date +%s)"
echo "Provisioning Desktop Environment"
echo "-----------------------------"

apt-get -y install --no-install-recommends ubuntu-desktop 
apt-get -y install --install-recommends unity indicator-session
apt-get -y install gnome-terminal

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in $(($end - $start)) seconds"
#!/bin/bash
start="$(date +%s)"
echo "-----------------------------"

apt-get -y install --no-install-recommends ubuntu-desktop 
apt-get -y install --install-recommends unity indicator-session
apt-get -y install gnome-terminal

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning of ubuntu desktop complete in "$(expr $end - $start)" seconds"
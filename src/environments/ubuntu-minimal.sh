#!/bin/bash
start="$(date +%s)"
logfile=/vagrant/vagrant.log

echo "Provisioning Desktop Environment"
echo "-----------------------------"

echo "Installing the minimal ubuntu-desktop, this may take a little bit."
apt-get -y install --no-install-recommends ubuntu-desktop >>$logfile 2>&1
apt-get -y install --install-recommends unity indicator-session >>$logfile 2>&1
apt-get -y install gnome-terminal >>$logfile 2>&1

end="$(date +%s)"
echo "-----------------------------"
echo "The provisioning step completed in $(($end - $start)) seconds"
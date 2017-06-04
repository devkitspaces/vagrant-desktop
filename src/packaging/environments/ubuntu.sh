#!/bin/bash
start="$(date +%s)"
logfile=/vagrant/vagrant.log

echo "Provisioning Desktop Environment"
echo "-----------------------------"

echo "Installing ubuntu-desktop, this may take a while."
apt-get -y install ubuntu-desktop >>$logfile 2>&1

end="$(date +%s)"
echo "-----------------------------"
echo "The provisioning step completed in $(($end - $start)) seconds"
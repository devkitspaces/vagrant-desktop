#!/bin/bash
start="$(date +%s)"
logfile=/vagrant/vagrant.log

echo "Provisioning Desktop Environment"
echo "-----------------------------"

echo "Installing the minimal lubuntu-desktop, this may take a little bit."
apt-get -y install --no-install-recommends lubuntu-desktop >>$logfile 2>&1

end="$(date +%s)"
echo "-----------------------------"
echo "The provisioning step completed in $(($end - $start)) seconds"
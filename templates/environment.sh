#!/bin/bash
start="$(date +%s)"
logfile=/vagrant/vagrant-$start.log

echo "Provisioning Desktop Environment"
echo "-----------------------------"

## A provision script to act as a template

end="$(date +%s)"
echo "-----------------------------"
echo "The provisioning step completed in "$(expr $end - $start)" seconds"
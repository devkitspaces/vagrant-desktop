#!/bin/bash
start="$(date +%s)"
echo "Provisioning Desktop Environment"
echo "-----------------------------"

apt-get -y install ubuntu-desktop

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in $(($end - $start)) seconds"
#!/bin/bash
start="$(date +%s)"
echo "-----------------------------"

apt-get -y install ubuntu-desktop

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning of ubuntu desktop complete in "$(expr $end - $start)" seconds"
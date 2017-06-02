#!/bin/bash
#=============================================================================
#
#          FILE:  prepare.sh
#
#         USAGE:  ./prepare.sh
#
#   DESCRIPTION: Prepares the environment for provisioning by updating essential
#       environment variables.  
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#        AUTHOR:  jrbeverly
#
#==============================================================================
start="$(date +%s)"

echo "-----------------------------"
echo "Checking for external network connection..."
ONLINE=$(nc -z 8.8.8.8 53  >/dev/null 2>&1)
if [[ $ONLINE -eq $zero ]]; then 
    echo "External network connection established, updating packages."
else
    echo "No external network available. Provisioning is halted."
    exit 1
fi

echo "-----------------------------"
echo "Updating..."
export DEBIAN_FRONTEND=noninteractive
apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

echo "-----------------------------"
echo "Setting timezone..."
if [[ -z "${DESKTOP_TZ}" ]]; then
    apt-get -y install python-pip
    pip install -U tzupdate
    tzupdate
else
    if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo "${DESKTOP_TZ}" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi
fi

echo "-----------------------------"
echo "Setting language as en_US..."
echo LANG=en_US.UTF-8 >> /etc/environment
echo LANGUAGE=en_US.UTF-8 >> /etc/environment
echo LC_ALL=en_US.UTF-8 >> /etc/environment
echo LC_CTYPE=en_US.UTF-8 >> /etc/environment

end="$(date +%s)"
echo "-----------------------------"
echo "Preparing the environment for provisioning completed in $(($end - $start)) seconds"
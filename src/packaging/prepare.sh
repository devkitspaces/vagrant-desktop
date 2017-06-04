#!/bin/bash
#=============================================================================
# Prepares the machine for provisioning the GUI Desktop environment.
#=============================================================================

#
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"

#
# Run
#
start="$(date +%s)"
logfile=/vagrant/vagrant.log

echo "-----------------------------"
echo "Checking for external network connection."
ONLINE=$(nc -z 8.8.8.8 53  >/dev/null 2>&1)
if [[ $ONLINE -eq $zero ]]; then 
    echo "External network connection established, updating packages."
else
    echo "No external network available. Provisioning is halted."
    exit 1
fi

echo "-----------------------------"
echo "Updating and upgrading the machine."
export DEBIAN_FRONTEND=noninteractive
apt-get -y update >>$logfile 2>&1
apt-get -y upgrade >>$logfile 2>&1
apt-get -y autoremove >>$logfile 2>&1

echo "-----------------------------"
echo "Setting timezone."
if [[ -z "${DESKTOP_TZ}" ]]; then
    echo "Installing and running tzupdate."
    apt-get -y install python-pip >>$logfile 2>&1
    pip install -U tzupdate >>$logfile 2>&1
    tzupdate >>$logfile 2>&1
else
    if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then 
        echo "${DESKTOP_TZ}" | tee /etc/timezone 
        dpkg-reconfigure --frontend noninteractive tzdata >>$logfile 2>&1; 
    fi
fi

echo "-----------------------------"
echo "Setting language as en_US..."
echo LANG=en_US.UTF-8 >> /etc/environment
echo LANGUAGE=en_US.UTF-8 >> /etc/environment
echo LC_ALL=en_US.UTF-8 >> /etc/environment
echo LC_CTYPE=en_US.UTF-8 >> /etc/environment
locale-gen en_US.UTF-8 >>$logfile 2>&1
dpkg-reconfigure locales >>$logfile 2>&1

end="$(date +%s)"
echo "-----------------------------"
echo "Preparing the environment for provisioning completed in $(($end - $start)) seconds"
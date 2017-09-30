#!/bin/bash
#=============================================================================
# Prepares the machine for provisioning the GUI Desktop environment.
#=============================================================================
export DEBIAN_FRONTEND=noninteractive

echo "Updating sources..." 1>&3
apt-get update

echo "Upgrading packages..." 1>&3
apt-get -y upgrade
apt-get -y autoremove

echo "Setting timezone..." 1>&3
if [[ -z "${DESKTOP_TZ}" ]]; then
    echo "Installing and running tzupdate..." 1>&3
    apt-get -y install python-pip
    pip install -U tzupdate
    tzupdate
else
    if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then 
        echo "${DESKTOP_TZ}" | tee /etc/timezone 
        dpkg-reconfigure --frontend noninteractive tzdata
    fi
fi

echo "Setting language as en_US..." 1>&3
echo LANG=en_US.UTF-8 >> /etc/environment
echo LANGUAGE=en_US.UTF-8 >> /etc/environment
echo LC_ALL=en_US.UTF-8 >> /etc/environment
echo LC_CTYPE=en_US.UTF-8 >> /etc/environment

locale-gen en_US.UTF-8
dpkg-reconfigure locales
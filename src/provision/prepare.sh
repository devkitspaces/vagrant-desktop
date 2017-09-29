#!/bin/bash
#=============================================================================
# Prepares the machine for provisioning the GUI Desktop environment.
#=============================================================================
export DEBIAN_FRONTEND=noninteractive

echo "Updating sources..."
apt-get update >>$VAGRANT_LOG 2>&1

echo "Upgrading packages..."
apt-get -y upgrade >>$VAGRANT_LOG 2>&1
apt-get -y autoremove >>$VAGRANT_LOG 2>&1

echo "Setting timezone..."
if [[ -z "${DESKTOP_TZ}" ]]; then
    echo "Installing and running tzupdate..."
    apt-get -y install python-pip >>$VAGRANT_LOG 2>&1
    pip install -U tzupdate >>$VAGRANT_LOG 2>&1
    tzupdate >>$VAGRANT_LOG 2>&1
else
    if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then 
        echo "${DESKTOP_TZ}" | tee /etc/timezone 
        dpkg-reconfigure --frontend noninteractive tzdata >>$VAGRANT_LOG 2>&1
    fi
fi

echo "Setting language as en_US..."
echo LANG=en_US.UTF-8 >> /etc/environment
echo LANGUAGE=en_US.UTF-8 >> /etc/environment
echo LC_ALL=en_US.UTF-8 >> /etc/environment
echo LC_CTYPE=en_US.UTF-8 >> /etc/environment

locale-gen en_US.UTF-8 >>$VAGRANT_LOG 2>&1
dpkg-reconfigure locales >>$VAGRANT_LOG 2>&1
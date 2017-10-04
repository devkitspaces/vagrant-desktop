#!/bin/bash
#=============================================================================
# Prepares any dependencies needed for the vagrant provisioning process.
#=============================================================================
echo "-----------------------------------------------------------"
echo "Checking for external network connection."
ONLINE=$(nc -z 8.8.8.8 53  >/dev/null 2>&1)
if [[ $ONLINE -eq $zero ]]; then 
    echo "External network connection established, updating packages."
else
    echo "No external network available. Provisioning is halted."
    exit 1
fi

echo "Writing provision logs $VAGRANT_LOG."

apt-get update >>$VAGRANT_LOG 2>&1
apt-get install -y boxes >>$VAGRANT_LOG 2>&1

echo "Essentials installed"
echo "-----------------------------------------------------------"
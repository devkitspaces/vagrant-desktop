#!/bin/bash
#=============================================================================
#
#          FILE:  bootstrap.sh
#
#         USAGE:  ./bootstrap.sh
#
#   DESCRIPTION: A boostrap script for the LUbuntu desktop environment
#                See http://lubuntu.net/
#
#       OPTIONS:  ENV[DESKTOP_TYPE]
#  REQUIREMENTS:  ---
#         NOTES:  The environment variable DESKTOP_TYPE should be set to either
#                  'minimal' or 'full'.
#        AUTHOR:  ---
#
#==============================================================================

start="$(date +%s)"

echo "-----------------------------"

if [ "$1" == 'full' ]; then
    apt-get -y install --install-recommends lubuntu-desktop 
else
    apt-get -y install --no-install-recommends lubuntu-desktop
fi

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning of lubuntu desktop complete in "$(expr $end - $start)" seconds"
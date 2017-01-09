#!/bin/bash
#=============================================================================
#
#          FILE:  bootstrap.sh
#
#         USAGE:  ./bootstrap.sh
#
#   DESCRIPTION: A boostrap script for the Ubuntu desktop environment
#                See https://www.ubuntu.com/
#
#       OPTIONS:  DESKTOP_TYPE
#                   The type of desktop [minimal|full]
#  REQUIREMENTS:  ---
#         NOTES:  The environment variable DESKTOP_TYPE should be set to either
#                  'minimal' or 'full'.
#        AUTHOR:  ---
#
#==============================================================================

start="$(date +%s)"

echo "-----------------------------"

if [ "$1" == 'full' ]; then
    apt-get -y install ubuntu-desktop
else
    apt-get -y install --no-install-recommends ubuntu-desktop 
    apt-get -y install --install-recommends unity indicator-session
    apt-get -y install gnome-terminal
fi

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning of ubuntu desktop complete in "$(expr $end - $start)" seconds"
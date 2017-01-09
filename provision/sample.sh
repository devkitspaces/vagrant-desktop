#!/bin/bash
#=============================================================================
#
#          FILE:  provision.sh
#
#         USAGE:  ./provision.sh
#
#   DESCRIPTION: The primary provisioning script for the linux desktop 
#       environment.  It setups the desktop to use have the necessary 
#       components for a good user experience.  
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#        AUTHOR:  jrbeverly
#
#==============================================================================

echo "+----------------------------------------+"
echo "| Provisioning Linux Desktop Environment |"
echo "+----------------------------------------+"

start="$(date +%s)"

## TODO: Copy this as 'provison' for vagrant desktop

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end - $start)" seconds"
echo "+---------------------------------------+"
echo "| Linux Desktop Environment Provisioned |"
echo "+---------------------------------------+"
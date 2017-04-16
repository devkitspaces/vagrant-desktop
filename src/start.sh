#!/bin/bash
#=============================================================================
#
#          FILE:  start.sh
#
#         USAGE:  ./start.sh
#
#   DESCRIPTION: Starts the vagrant environment with provided arguments.
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#        AUTHOR:  jrbeverly
#
#==============================================================================

# Variables
#
# Variables used when starting up the vagrant environment.
NAME=""
DESKTOP=""

environment_dir="provision/environments"
script_match=false

# Options
#
# Parses the options provided to the script.
while getopts "h?:n:d:" opt; do
    case $opt in
        h|\?)
            echo "Usage: $0 -n NAME -d DESKTOP"
            echo
            echo "Starts the vagrant environment with provided arguments." 
            exit 0
        ;;
        n) NAME=$OPTARG
        ;;
        d) DESKTOP=$OPTARG
        ;;
    esac
done

if [[ -z "$NAME" ]]; then
    echo "The argument '-n NAME' was not provided."
    exit 1
fi

if [[ -z "$DESKTOP" ]]; then
    echo "The argument '-d DESKTOP' was not provided."
    exit 1
fi

for file in $environment_dir/*; do
  filename=${file##*/}
  name=$(echo $filename | cut -f 1 -d '.')
  if [ $DESKTOP = $name ]; then
    script_match=true
    break
  fi
done

if [ "$script_match" = false ] ; then
    echo "The argument '-d DESKTOP' does not match any of the environments available in 'environments/'."
    exit 1
fi

# Provision
#
# Starts and provisions the vagrant environment.
vagrant --name=$NAME --desktop=$DESKTOP up
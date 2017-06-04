#!/bin/bash
#=============================================================================
# Constructs the vagrant environment with provided arguments.
#=============================================================================
set -e

# 
# Variables
# 
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
ENVIRONMENT_DIR="${DIR}/packaging/environments"

#
# Options
#
name=""
desktop=""

# 
# Option Parsing
#
while getopts "h?:n:d:" opt; do
    case $opt in
        h|\?)
            echo "Usage: $0 -n name -d desktop"
            echo
            echo "Starts the vagrant environment with provided arguments." 
            exit 0
        ;;
        n) name=$OPTARG
        ;;
        d) desktop=$OPTARG
        ;;
    esac
done

if [[ -z "$name" ]]; then
    echo "The argument '-n name' was not provided."
    exit 1
fi

if [[ -z "$desktop" ]]; then
    echo "The argument '-d desktop' was not provided."
    exit 1
fi

DESKTOP_SCRIPT="$ENVIRONMENT_DIR/$desktop.sh"
if [ ! -f "$DESKTOP_SCRIPT" ]
then
    echo "The argument '-d $desktop' does not match any of the environments available in 'environments/'."
    exit 1
fi

#
# Vagrant
#
cd $DIR

echo "Preparing the environment, this will take a while."
vagrant --name=$name --desktop=$desktop up
sleep 10

echo "Restarting the newly created environment."
vagrant halt
sleep 5

echo "The environment is ready!"
vagrant up
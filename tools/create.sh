#!/bin/bash
#=============================================================================
# Constructs the vagrant environment with provided arguments.
#=============================================================================
set -e

# 
# Variables
# 
DIR=$(dirname "$(readlink -f "$0")")
DIR_ROOT="$(dirname "$DIR")"
DIR_SRC="$DIR_ROOT/src"

#
# Options
#
name=""
file=""

# 
# Option Parsing
#
while getopts "h?:n:f:" opt; do
    case $opt in
        h|\?)
            echo "Usage: $0 -n name -f file"
            echo
            echo "Starts the vagrant environment with provided arguments." 
            exit 0
        ;;
        n) name=$OPTARG
        ;;
        f) file=$OPTARG
        ;;
    esac
done

if [[ -z "$name" ]]; then
    echo "The argument '-n name' was not provided."
    exit 1
fi

if [[ -z "$file" ]]; then
    echo "The argument '-f file' was not provided."
    exit 1
fi

#
# Vagrant
#
filepath="$(cd "$(dirname '$file')" &>/dev/null && printf "%s/%s" "$PWD" "${file##*/}")"
cd $DIR_SRC

echo "Preparing the environment, this will take a while."

echo "vagrant --name='$name' --file='$filepath' up"
vagrant --name="$name" --file="$filepath" up
echo "Preparing to halt the environment."

sleep 20

echo "Preparing to restart the newly created environment."
#vagrant --name="$name" --file="$filepath" halt
echo "Restarting the newly created environment."

sleep 20

echo "The environment is ready!"
vagrant --name="$name" --file="$filepath" up
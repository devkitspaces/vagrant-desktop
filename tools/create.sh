#!/bin/bash
#=============================================================================
# Constructs the vagrant environment with provided arguments.
#=============================================================================
set -e

# 
# Variables
# 
DIR=$(dirname "$(readlink -f "$0")")
DIR_ROOT="$(dirname $DIR)"
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
cd $DIR_SRC

echo "Preparing the environment, this will take a while."
vagrant --name=$name --file=$file up
#sleep 10

#echo "Restarting the newly created environment."
#vagrant halt
#sleep 5

#echo "The environment is ready!"
#vagrant up
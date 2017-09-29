#!/bin/bash
#=============================================================================
# Acts as an entrypoint for all scripts running using the `vagrant_copy_run` 
# command.

# Usage:
#  $ ./entrypoint.bash name script [args]
#
# * message: The friendly display message for output.
# * script: The path to the script for execution.
# * args: The arguments to pass to the script.
#=============================================================================
BOX_SIZE=60

# ---------------------------------------
# Parameters
# ---------------------------------------  

MESSAGE="$1"
SCRIPT_PATH="$2"
SCRIPT_NAME="$(basename $SCRIPT_PATH)"
shift
shift
ARGS="$@"

# ---------------------------------------
# Main
# --------------------------------------- 

printf "\n$MESSAGE\n\n"  | boxes -d html -s $BOX_SIZE
START_TIME="$(date +%s)"
export DEBIAN_FRONTEND=noninteractive
bash "$SCRIPT_PATH" $ARGS
END_TIME="$(date +%s)"
printf "\nThe provision script '$SCRIPT_NAME' has completed\n The script completed within $(($END_TIME - $START_TIME)) seconds\n\n" | boxes -d html -s $BOX_SIZE
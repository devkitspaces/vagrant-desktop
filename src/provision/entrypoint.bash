#!/bin/bash
#=============================================================================
# Acts as an entrypoint for all scripts running using the `vagrant_copy_run` 
# command.

# Usage:
#  $ ./entrypoint.bash name script [args]
#
# * name: The friendly display name of the script for output.
# * script: The path to the script for execution.
# * args: The arguments to pass to the script.
#=============================================================================
NAME="$1"
SCRIPT_PATH="$2"
shift
shift
ARGS="$@"

echo "Starting the provision script '$NAME'"  | boxes -d html -s 40
START_TIME="$(date +%s)"
bash "$SCRIPT_PATH" $ARGS
END_TIME="$(date +%s)"
echo "The provision script '$NAME' has completed within $(($END_TIME - $START_TIME)) seconds"  | boxes -d html -s 40
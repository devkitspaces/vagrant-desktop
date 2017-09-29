#!/bin/bash
start="$(date +%s)"

echo "Provisioning Environment"
echo "-----------------------------"

## A provision script to act as a template

end="$(date +%s)"
echo "-----------------------------"
echo "The provisioning step completed in "$(expr $end - $start)" seconds"
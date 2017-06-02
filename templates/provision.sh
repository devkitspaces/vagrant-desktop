#!/bin/bash
start="$(date +%s)"
echo "Provisioning Environment"
echo "-----------------------------"

## A provision script to act as a template

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end - $start)" seconds"
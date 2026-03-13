#!/bin/bash

set -eufo pipefail

osascript -e 'tell application "System Preferences" to quit'

echo "Applying power settings..."

# Disable brightness reduction on battery power
sudo pmset -a lessbright 0

# Set display sleep and system sleep times
sudo pmset -b displaysleep 5 sleep 6
sudo pmset -c displaysleep 15 sleep 17

echo "Power settings applied."

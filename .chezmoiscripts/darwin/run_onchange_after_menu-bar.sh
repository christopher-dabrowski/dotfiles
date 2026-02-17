#!/bin/bash

set -eufo pipefail

osascript -e 'tell application "System Preferences" to quit'

# Configure date and time
defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
defaults write com.apple.menuextra.clock "ShowAMPM" -bool false
defaults write com.apple.menuextra.clock "ShowDate" -int 2
defaults write com.apple.menuextra.clock "ShowDayOfWeek" -bool false

# Menu bar: show battery percentage
defaults -currentHost write com.apple.controlcenter Battery -int 18
defaults -currentHost write com.apple.controlcenter.plist BatteryShowPercentage -bool true

# Show Bluetooth in menu bar
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18

# Wi-Fi
defaults -currentHost write com.apple.controlcenter WiFi -int 18

# Sound / Volume
defaults -currentHost write com.apple.controlcenter Sound -int 18

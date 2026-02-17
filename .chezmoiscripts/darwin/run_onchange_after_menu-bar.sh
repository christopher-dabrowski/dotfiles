#!/bin/bash

set -eufo pipefail

osascript -e 'tell application "System Preferences" to quit'

# Configure date and time
defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
defaults write com.apple.menuextra.clock "ShowAMPM" -bool false
defaults write com.apple.menuextra.clock "ShowDate" -int 2
defaults write com.apple.menuextra.clock "ShowDayOfWeek" -bool false

# Menu bar: show battery percentage
defaults -currentHost write com.apple.controlcenter.plist BatteryShowPercentage -bool true

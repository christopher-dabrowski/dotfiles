#!/bin/bash

set -eufo pipefail

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don't automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# Set Dock size
defaults write com.apple.dock tilesize -int 53

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/System/Applications/Utilities/Activity Monitor.app"
dockutil --no-restart --add "/Applications/kitty.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Bitwarden.app"
dockutil --no-restart --add "~/Downloads" --view auto --display stack --sort dateadded

# Mission Control workaround for Aerospace https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
defaults write com.apple.dock expose-group-apps -bool true

killall Dock

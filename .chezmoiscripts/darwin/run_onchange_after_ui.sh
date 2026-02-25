#!/bin/bash

set -eufo pipefail

osascript -e 'tell application "System Preferences" to quit'

# Disable Displays have separate Spaces. Improves performance of AeroSpace https://nikitabobko.github.io/AeroSpace/guide#a-note-on-displays-have-separate-spaces
defaults write com.apple.spaces spans-displays -bool true

killall SystemUIServer

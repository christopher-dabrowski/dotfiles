#!/bin/bash

set -eufo pipefail

defaults write org.p0deje.Maccy ignoredApps -array "com.bitwarden.desktop"
defaults write org.p0deje.Maccy pasteByDefault -bool true
defaults write org.p0deje.Maccy searchMode -string "fuzzy"
defaults write org.p0deje.Maccy removeFormattingByDefault -bool false

# Set global hotkey to ⌘ + Shift + V
defaults write org.p0deje.Maccy KeyboardShortcuts_popup -string "{\"carbonModifiers\":768,\"carbonKeyCode\":9}"

# automatic updates
defaults write org.p0deje.Maccy SUEnableAutomaticChecks -bool true

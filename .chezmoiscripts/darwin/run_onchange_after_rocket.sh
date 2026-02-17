#!/bin/bash

set -eufo pipefail

defaults write net.matthewpalmer.Rocket deactivated-apps -array \
    "Slack" \
    "Xcode" \
    "Terminal" \
    "iTerm2" \
    "Obsidian"

defaults write net.matthewpalmer.Rocket launch-at-login -bool true
defaults write net.matthewpalmer.Rocket use-fuzzy-search -bool true

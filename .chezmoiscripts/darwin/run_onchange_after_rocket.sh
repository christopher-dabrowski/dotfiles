#!/bin/bash

set -eufo pipefail

defaults write net.matthewpalmer.Rocket deactivated-apps -array \
  "Slack" \
  "Xcode" \
  "Terminal" \
  "iTerm2" \
  "Obsidian" \
  "kitty"

defaults write net.matthewpalmer.Rocket deactivated-website-patterns -array \
  "github.com" \
  "trello.com" \
  "slack.com" \
  "archidekt.com" \
  "mpcfill.com" \
  "scryfall.com" \
  "vim-adventures.com"

defaults write net.matthewpalmer.Rocket launch-at-login -bool true
defaults write net.matthewpalmer.Rocket use-fuzzy-search -bool true

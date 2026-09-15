#!/bin/bash

set -eufo pipefail

defaults write digital.twisted.noTunes hideIcon -bool true
defaults write digital.twisted.noTunes replacement https://music.youtube.com/

osascript -e 'quit app "noTunes"'
open -a noTunes

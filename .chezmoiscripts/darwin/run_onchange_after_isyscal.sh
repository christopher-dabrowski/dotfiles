#!/bin/bash

set -eufo pipefail

defaults write com.mowglii.ItsycalApp ClockFormat -string "E dd.MM.yyyy"
defaults write com.mowglii.ItsycalApp HideIcon -bool true
defaults write com.mowglii.ItsycalApp ShowEventDays -int 7

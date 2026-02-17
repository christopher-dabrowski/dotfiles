#!/bin/bash

set -eufo pipefail

osascript -e 'tell application "System Preferences" to quit'

apps=(
  "Maccy"
  "Rocket"
  "Itsycal"
  "BetterTouchTool"
  "Bitwarden"
)

osascript <<'APPLESCRIPT'
tell application "System Events"
  set loginItems to (every login item)
  repeat with li in loginItems
    delete li
  end repeat
end tell
APPLESCRIPT

for app in "${apps[@]}"; do
  if [ -d "/Applications/$app.app" ]; then
    osascript -e "tell application \"System Events\" to make login item at end with properties {name:\"$app\", path:\"/Applications/$app.app\", hidden:false}" 2>/dev/null || true
  fi
done

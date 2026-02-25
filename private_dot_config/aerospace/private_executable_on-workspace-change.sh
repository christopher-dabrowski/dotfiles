#!/usr/bin/env bash
set -euo pipefail

PATH="/usr/local/bin/:$PATH"

case "${AEROSPACE_FOCUSED_WORKSPACE:-}" in
  N)
    if ! pgrep -x Obsidian >/dev/null 2>&1; then
      open -a Obsidian
    fi
    ;;
  T)
    if ! pgrep -x kitty >/dev/null 2>&1; then
      open -a kitty
    fi
    ;;
  P)
    if ! pgrep -x Bitwarden >/dev/null 2>&1; then
      open -a Bitwarden
    fi
    ;;
  C)
    if ! (aerospace list-windows --workspace C 2>/dev/null | grep -q "Brave Browser"); then
      # terminal-notifier -message "Launching Brave Browser for workspace C"
      existing_ids=$(aerospace list-windows --all 2>/dev/null | grep "Brave Browser" | awk '{print $1}' || true)
      # terminal-notifier -message "Existing Brave Browser window IDs: $existing_ids"
      "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" --new-window https://calendar.google.com &
      # terminal-notifier -message "Launched Brave Browser with Google Calendar"
      sleep 1
      new_id=$(aerospace list-windows --all 2>/dev/null | grep "Brave Browser" | awk '{print $1}' | grep -vxF "$existing_ids" | head -1 || true)
      # terminal-notifier -message "New Brave Browser window ID: $new_id"
      if [ -n "$new_id" ]; then
        aerospace move-node-to-workspace --window-id "$new_id" C
        # terminal-notifier -message "Moved Brave Browser to workspace C"
        aerospace focus --window-id "$new_id"
        # terminal-notifier -message "Focused Brave Browser in workspace C"
      fi
    fi
    ;;
esac

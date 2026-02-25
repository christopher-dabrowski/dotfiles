#!/usr/bin/env bash
set -euo pipefail

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
esac

#!/usr/bin/env bash
set -euo pipefail

if [ "${AEROSPACE_FOCUSED_WORKSPACE:-}" = "N" ]; then
  if ! pgrep -x Obsidian >/dev/null 2>&1; then
    open -a Obsidian
  fi
fi

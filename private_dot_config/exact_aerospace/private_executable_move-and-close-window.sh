#!/usr/bin/env bash
set -euo pipefail

PATH="/usr/local/bin/:$PATH"

WIN_ID=$(aerospace list-windows --focused --format '%{window-id}')
aerospace focus-back-and-forth || aerospace workspace-back-and-forth
aerospace move-node-to-workspace 1 --window-id "$WIN_ID"
aerospace close --window-id "$WIN_ID"

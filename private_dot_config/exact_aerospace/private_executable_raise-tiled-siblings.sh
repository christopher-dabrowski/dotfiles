#!/usr/bin/env bash
# Raise all windows of a tiles container nested in an accordion, not just the focused one.
#
# Accordion children overlap, and AeroSpace only raises the window it focuses, so switching
# from e.g. VS Code back to one of two side-by-side terminals leaves the other terminal hidden
# behind VS Code. Focusing every sibling and then the original window again raises them all.
set -euo pipefail

PATH="/usr/local/bin/:$PATH"

# The focus commands below re-trigger on-focus-changed; skip those nested runs.
lock="${TMPDIR:-/tmp}/aerospace-raise-tiled-siblings.lock"
mkdir "$lock" 2>/dev/null || exit 0
trap 'sleep 0.3; rmdir "$lock"' EXIT

read -r focused_id focused_layout < <(
  aerospace list-windows --focused --format '%{window-id} %{window-parent-container-layout}'
) || exit 0

[[ $focused_layout == *_tiles ]] || exit 0

windows=$(aerospace list-windows --workspace focused --format '%{window-id} %{window-parent-container-layout}')

# Only needed when the tiles container sits inside an accordion
grep -q '_accordion$' <<<"$windows" || exit 0

siblings=$(awk -v id="$focused_id" -v layout="$focused_layout" '$1 != id && $2 == layout { print $1 }' <<<"$windows")
[[ -n $siblings ]] || exit 0

for id in $siblings; do
  aerospace focus --window-id "$id"
done
aerospace focus --window-id "$focused_id"

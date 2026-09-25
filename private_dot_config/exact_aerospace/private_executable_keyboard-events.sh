#!/usr/bin/env bash

set -euo pipefail

event="${1:?Expected a brightness, illumination, or volume event}"

case "$event" in
  brightness-down)
    key="BRIGHTNESS_DOWN"
    repeats=1
    ;;
  brightness-up)
    key="BRIGHTNESS_UP"
    repeats=1
    ;;
  brightness-down-big)
    key="BRIGHTNESS_DOWN"
    repeats=4
    ;;
  brightness-up-big)
    key="BRIGHTNESS_UP"
    repeats=4
    ;;
  illumination-down)
    key="ILLUMINATION_DOWN"
    repeats=1
    ;;
  illumination-up)
    key="ILLUMINATION_UP"
    repeats=1
    ;;
  illumination-min)
    key="ILLUMINATION_DOWN"
    repeats=20
    ;;
  illumination-max)
    key="ILLUMINATION_UP"
    repeats=20
    ;;
  volume-down)
    key="SOUND_DOWN"
    repeats=1
    ;;
  volume-up)
    key="SOUND_UP"
    repeats=1
    ;;
  volume-down-big)
    key="SOUND_DOWN"
    repeats=4
    ;;
  volume-up-big)
    key="SOUND_UP"
    repeats=4
    ;;
  *)
    printf 'Unknown event: %s\n' "$event" >&2
    exit 2
    ;;
esac

for ((index = 0; index < repeats; index++)); do
  /usr/local/bin/hs -c "hs.eventtap.event.newSystemKeyEvent(\"$key\", true):post(); hs.eventtap.event.newSystemKeyEvent(\"$key\", false):post()"
done
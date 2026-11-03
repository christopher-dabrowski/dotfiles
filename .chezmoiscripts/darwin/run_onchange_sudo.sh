#!/bin/bash

set -eufo pipefail

echo "Applying sudo settings..."

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

# Show asterisks while typing the password
echo "Defaults pwfeedback" >"$tmp"

# Validate before installing, a broken sudoers file can lock out sudo
sudo visudo -cf "$tmp"
sudo install -m 0440 -o root -g wheel "$tmp" /etc/sudoers.d/pwfeedback

echo "Sudo settings applied."

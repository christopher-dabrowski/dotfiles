#!/bin/sh
set -eufo pipefail

echo "Installing mise"

curl https://mise.run | sh

echo "mise installed, now installing mise tools"

mise install --yes

echo "mise tools installed"


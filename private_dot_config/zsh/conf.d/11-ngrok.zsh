# vim: set filetype=sh:

# ngrok shell autocomplete
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

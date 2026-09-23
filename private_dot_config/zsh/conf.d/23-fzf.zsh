# vim: set filetype=sh:

# Set up fzf key bindings and fuzzy completion
# CTRL-t - Fuzzy find all files and subdirectories of the working directory, and output the selection to STDOUT.
# CTRL-r - Fuzzy find command history.
# ALT-c - Fuzzy change directory.
# We can also complete some shell commands using fzf, by default triggered with ** (followed by TAB).
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# vim: set filetype=sh:
#
# All fpath additions live here, in one place, so it's easy to see what
# feeds compinit. This file must be sourced before compinit runs.

# Homebrew-installed completions (auto-populated by formulas)
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
fi

# Our own hand-maintained completions
fpath+=("$HOME/.local/share/zsh/site-functions")

# Docker CLI completions
[[ -d "$HOME/.docker/completions" ]] && fpath+=("$HOME/.docker/completions")

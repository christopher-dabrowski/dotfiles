# vim: set filetype=sh:

# Alias for logging in to PW laboratories server
alias volt="ssh dabrowk1@volt.iem.pw.edu.pl"

# Update all pip3 packages
alias pip3-upgrade="pip3 list --outdated --format=freeze | cut -d = -f 1 | xargs -n1 pip3 install -U"

# Activate venv
alias venv-activate="source ./venv/bin/activate"

chezmoi-cd() {
  cd "$(chezmoi source-path)" || exit 1
}

eval $(thefuck --alias)

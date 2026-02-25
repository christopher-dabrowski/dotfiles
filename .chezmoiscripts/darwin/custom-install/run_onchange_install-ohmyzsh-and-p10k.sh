#!/bin/sh
set -eu

# Ensure brew (optional but helps avoid interactive Xcode git prompts)
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Oh My Zsh (don’t auto-run zsh, don’t change shell, don’t overwrite managed .zshrc)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  export RUNZSH=no CHSH=no KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Plugins used by your plugins=(...) list
for repo in \
  https://github.com/zsh-users/zsh-autosuggestions \
  https://github.com/zsh-users/zsh-syntax-highlighting \
  https://github.com/zsh-users/zsh-history-substring-search
do
  name="$(basename "$repo")"
  [ -d "$ZSH_CUSTOM/plugins/$name" ] || git clone --depth=1 "$repo" "$ZSH_CUSTOM/plugins/$name"
done

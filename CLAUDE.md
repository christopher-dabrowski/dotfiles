# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles for macOS, managed with [chezmoi](https://www.chezmoi.io/). This is the chezmoi _source directory_ — files here are templates/source representations of what chezmoi applies to the user's home directory (`~`). There is no build step, test suite, or compiler; "correctness" means the chezmoi naming/templating rules are followed and the target file ends up in the right place with the right content.

## chezmoi source-file naming (read before editing/adding any file)

chezmoi encodes target path, permissions, and behavior in the _source_ filename. Key prefixes used in this repo:

- `dot_foo` → applies as `~/.foo` (e.g. `dot_zshrc` → `~/.zshrc`).
- `private_dot_foo` → applies as `~/.foo` with permissions restricted (no group/other access) — used for things like `private_dot_ssh`, `private_dot_config`.
- `private_executable_foo.sh` → applied as an executable script with restricted permissions (used under `private_dot_config/aerospace/`).
- `symlink_foo` → chezmoi creates a symlink at the target rather than a copy (its file contents are the symlink target).
- `run_onchange_*.sh` / `run_onchange_*.sh.tmpl` (under `.chezmoiscripts/`) → scripts chezmoi runs automatically when their content changes (hash of the rendered script is the trigger), used for one-time/idempotent machine setup (installing packages, macOS defaults, etc). `run_onchange_after_*` runs after files are applied; scripts without `_after_` run before.
- `.tmpl` suffix → the file is a Go template, rendered with chezmoi data (see `.chezmoidata/`) and `.chezmoi.*` variables (e.g. `.chezmoi.os`) before being written.
- `.chezmoiignore.tmpl` → template-driven ignore list; branches on `.chezmoi.os` to skip OS-specific scripts/files (e.g. Windows-only zsh files are ignored on non-Windows).
- `.chezmoidata/packages.yaml` → single source of truth for Homebrew taps/brews/casks (and other package data), consumed by the `run_onchange_install-packages_*.sh.tmpl` scripts via `{{ range .packages.darwin.* }}`.

When adding a new dotfile, mirror the naming convention of sibling files in the same directory rather than inventing a new pattern.

## Common chezmoi commands

```sh
chezmoi diff                 # preview what would change in $HOME before applying
chezmoi apply                # apply source state to $HOME
chezmoi apply -v             # verbose apply (show what changed)
chezmoi cd                   # cd into this source directory (equivalent to being here)
chezmoi execute-template < file.tmpl   # render a template to check its output
chezmoi state data           # inspect template data (.chezmoi.*, .chezmoidata contents)
chezmoi re-add                # pull local edits under ~ back into the source dir for a managed file
```

There is no lint/test command in this repo; validate changes by rendering templates (`chezmoi execute-template`) and running `chezmoi diff`/`chezmoi apply` (the latter mutates the real home directory — confirm with the user before running it, since it's not a sandboxed operation).

## Structure

- `.chezmoiscripts/darwin/` — macOS provisioning scripts, split by concern: package installs (`custom-install/`), Dock, Finder, trackpad, power, localization, default apps, menu bar, and per-app quirks (Itsycal, Maccy, noTunes, Rocket). These run automatically on `chezmoi apply` when their rendered content changes.
- `.chezmoidata/packages.yaml` — declarative list of Homebrew taps/brews/casks; edit here rather than editing the install scripts directly.
- `private_dot_config/` — XDG config dirs, one subfolder per tool (aerospace, mise, nvim, git, kitty, lazygit, btop, thefuck, gh, tombi, karabiner...).
- `private_dot_config/nvim/` — a [LazyVim](https://www.lazyvim.org/)-based Neovim config. Core LazyVim wiring lives in `lua/config/` (`lazy.lua`, `options.lua`, `keymaps.lua`, `autocmds.lua`); user customizations/plugin overrides live in `lua/plugins/` as one file per concern (`extend-*.lua` files extend a built-in LazyVim plugin spec, others add new plugins).
- `private_dot_config/mise/config.toml` — [mise](https://mise.jdx.dev/) tool version manager config; language/CLI tool versions (node, go, rust, gh, etc.) belong here rather than as Homebrew formulas. Currently mise is used for some of the tools instead of Homebrew becose of the user working on Intel Mac an Hombrew no longer supports pre-built binaries for Intel Macs formulas.
- `private_dot_config/aerospace/private_aerospace.toml` — [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling WM config, plus `private_executable_*.sh` helper scripts it shells out to for workspace-change/window-move/keyboard-event hooks.
- `dot_zshrc`, `dot_zprofile`, `dot_zshenv`, `dot_p10k.zsh` — zsh setup (Powerlevel10k prompt, PATH management, aliases). `dot_zshrc` is guarded by OS templating in `.chezmoiignore.tmpl` for non-Windows/Windows split behavior.
- `private_dot_ssh/` — SSH client config (private permissions).

## Editing conventions

- `.editorconfig` at the repo root applies: 2-space indent, LF line endings, UTF-8, trailing newline, trailing whitespace trimmed (except in `.md` files).
- Package installation should go through `.chezmoidata/packages.yaml`, not be hardcoded into `.chezmoiscripts/darwin/*.sh.tmpl`.
- Machine-specific, one-time setup (defaults writes, app installs, permission grants) belongs in a new `run_onchange_*` script under `.chezmoiscripts/darwin/`, following the existing single-concern-per-script pattern.

# AGENTS.md

## Hard rules

- **Never edit a managed file directly under `~`.** Edit the source file here, or pull local edits
  back in with `chezmoi re-add <path>`. Editing the target silently diverges from source state.
- **`chezmoi apply` mutates the real home directory — confirm with the user before running it.**
  It is not a sandboxed operation. There is no lint/test command in this repo; validate changes with
  `chezmoi execute-template < file.tmpl` and `chezmoi diff`.
- After editing or adding a file, run `chezmoi diff` and confirm it changes exactly the expected path
  under `~` — and nothing else.
- For a new file, run `chezmoi target-path <source path>` and check the target is what you intended.
  Pick the prefix from the naming section below; do not stack `symlink_` with `private_`.
- Package installation goes through `.chezmoidata/packages.yaml` or using mise CLI as an alternative, never hardcoded into
  `.chezmoiscripts/darwin/*.sh.tmpl`.
- Machine-specific, one-time setup (defaults writes, app installs, permission grants) belongs in a new
  `run_onchange_*` script under `.chezmoiscripts/darwin/`. One script = one settings domain (the
  existing split is Dock, Finder, trackpad, power, …); never append settings for one app to another
  app's script.
- `.editorconfig` at the repo root applies to every file here — see `@.editorconfig`.

## What this is

Personal dotfiles for macOS, managed with [chezmoi](https://www.chezmoi.io/). This is the chezmoi
_source directory_ — files here are templates/source representations of what chezmoi applies to the
user's home directory (`~`). There is no build step, test suite, or compiler; "correctness" means the
target file lands at the path `chezmoi diff` says it does, with the rendered content you expect.

## chezmoi source-file naming (read before editing/adding any file)

chezmoi encodes target path, permissions, and behavior in the _source_ filename — see
[source state attributes](https://www.chezmoi.io/reference/source-state-attributes/) for the full set.
Repo-specific points that the reference won't tell you:

- `private_executable_foo.sh` — used under `private_dot_config/aerospace/` for the helper scripts
  AeroSpace shells out to.
- `run_onchange_after_*` runs after files are applied; `run_onchange_*` without `_after_` runs before.
  The trigger is a hash of the _rendered_ script, so template data changes re-run it.
- `.chezmoiignore.tmpl` branches on `.chezmoi.os` to skip OS-specific scripts/files (e.g. Windows-only
  zsh files are ignored on non-Windows).
- `.chezmoidata/packages.yaml` is the single source of truth for Homebrew taps/brews/casks, consumed by
  `run_onchange_install-packages_*.sh.tmpl` via `{{ range .packages.darwin.* }}`.

When adding a new dotfile, mirror the naming of sibling files in the same directory rather than
inventing a new pattern.

## Structure

- `.chezmoiscripts/darwin/` — macOS provisioning scripts, split by concern: package installs
  (`custom-install/`), Dock, Finder, trackpad, power, localization, default apps, menu bar, and per-app quirks (Itsycal, Maccy, noTunes, Rocket). These run on `chezmoi apply` when their rendered content changes.
- `.chezmoidata/packages.yaml` — declarative list of Homebrew taps/brews/casks; edit here rather than
  editing the install scripts directly.
- `private_dot_config/` — XDG config dirs, one subfolder per tool (aerospace, mise, nvim, git, kitty,
  lazygit, btop, thefuck, gh, tombi, karabiner...).
- `private_dot_config/nvim/` — a [LazyVim](https://www.lazyvim.org/)-based Neovim config. Local
  convention: in `lua/plugins/`, `extend-*.lua` files extend a built-in LazyVim plugin spec, all other
  files add new plugins.
- `private_dot_config/mise/config.toml` — [mise](https://mise.jdx.dev/) tool version manager config;
  language/CLI tool versions (node, go, rust, gh, etc.) belong here rather than as Homebrew formulas.
  mise is used instead of Homebrew for these because the user is on an Intel Mac and Homebrew no longer ships pre-built binaries for Intel Mac formulas.
- `private_dot_config/aerospace/private_aerospace.toml` —
  [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling WM config, plus `private_executable_*.sh`
  helper scripts it shells out to for workspace-change/window-move/keyboard-event hooks.
- `dot_zshrc`, `dot_zprofile`, `dot_zshenv`, `dot_p10k.zsh` — zsh setup (Powerlevel10k prompt, PATH
  management, aliases). `dot_zshrc` is guarded by OS templating in `.chezmoiignore.tmpl` for
  non-Windows/Windows split behavior.
- `private_dot_ssh/` — SSH client config (private permissions).

## Non-obvious chezmoi commands

```sh
chezmoi re-add                          # pull local edits under ~ back into the source dir
chezmoi execute-template < file.tmpl    # render a template to check its output
chezmoi state data                      # inspect template data (.chezmoi.*, .chezmoidata contents)
chezmoi target-path <source path>       # show where a source file will be applied
```

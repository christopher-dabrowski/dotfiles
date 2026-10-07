# Keep new VS Code windows on the AeroSpace workspace `code` was run from.
#
# VS Code is a single app, so `code .` activates it and focuses one of its existing windows;
# AeroSpace follows that focus to the other window's workspace, and the new window can land
# there too. This wrapper finds the window that `code` opened and moves it back.
# `-r`/`--reuse-window` and non-window commands (extensions, version, help, ...) pass through.
if (( $+commands[aerospace] && $+commands[code] )); then
  _code_aerospace_windows() {
    aerospace list-windows --all --app-bundle-id com.microsoft.VSCode --format '%{window-id}' 2>/dev/null | sort
  }

  code() {
    local arg
    for arg in "$@"; do
      case $arg in
        --) break ;;
        -r|--reuse-window|-h|--help|-v|--version|-s|--status|--locate-shell-integration-path|\
        --install-extension|--uninstall-extension|--list-extensions|--update-extensions|--show-versions)
          command code "$@"
          return
          ;;
      esac
    done
    [[ $1 == (tunnel|serve-web) ]] && { command code "$@"; return }

    local ws before
    ws=$(aerospace list-workspaces --focused 2>/dev/null) || { command code "$@"; return }
    before=$(_code_aerospace_windows)

    # Poll in the background so `code --wait` still blocks, and give up after ~10 s
    # (e.g. the folder was already open, or a file opened in an existing window).
    {
      local new _
      for _ in {1..100}; do
        sleep 0.1
        new=$(comm -13 <(print -r -- "$before") <(_code_aerospace_windows) | head -n 1)
        if [[ -n $new ]]; then
          aerospace move-node-to-workspace --window-id "$new" "$ws" 2>/dev/null
          aerospace focus --window-id "$new" 2>/dev/null
          break
        fi
      done
    } &!

    command code "$@"
  }
fi

local XDG_CONFIG_DIR = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = {
            "--config",
            XDG_CONFIG_DIR .. "/markdownlint-cli2/config.yaml",
            "--",
          },
        },
      },
    },
  },
}

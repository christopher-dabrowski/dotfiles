return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Set your default theme
      colorscheme = "tokyonight",
    },
  },
  -- Follow the system dark/light mode: kitty notifies Neovim of theme changes
  -- (DEC mode 2031), Neovim updates 'background', and tokyonight reloads with
  -- the matching style.
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm", -- used when 'background' is dark
      light_style = "day", -- used when 'background' is light
    },
  },
}

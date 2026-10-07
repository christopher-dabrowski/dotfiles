return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Set your default theme
      colorscheme = "tokyonight",
    },
  },
  -- Configure color scheme to change based on background
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "day", -- This will be overridden by LazyVim's light/dark handling
      light_style = "day",
      dark_style = "storm",
    },
  },
}

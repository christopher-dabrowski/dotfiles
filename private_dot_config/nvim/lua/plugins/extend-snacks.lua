return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            -- Override default new tab behavior to send results to Trouble
            ["<c-t>"] = { "trouble_open", mode = { "n", "i" }, desc = "Send to Trouble" },
          },
        },
      },
    },
  },
}

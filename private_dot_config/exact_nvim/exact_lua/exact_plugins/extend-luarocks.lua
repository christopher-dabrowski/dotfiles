return {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- high priority required, luarocks.nvim should run as the first plugin in your config
  lazy = false,
  opts = {
    rocks = { "luautf8" },
  },
}

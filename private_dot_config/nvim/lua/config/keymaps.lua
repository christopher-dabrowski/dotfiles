-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if _G.nvimpager then
  -- Use 'q' to quit nvimpager
  vim.keymap.set({ "n", "v", "x" }, "q", "<cmd>qa!<cr>", { desc = "Quit nvimpager" })
end

if vim.g.vscode then
  local vscode = require("vscode")

  -- Jump to the next git hunk
  vim.keymap.set("n", "]h", function()
    vscode.action("workbench.action.editor.nextChange")
  end, { desc = "Next git hunk" })

  -- Jump to the previous git hunk
  vim.keymap.set("n", "[h", function()
    vscode.action("workbench.action.editor.previousChange")
  end, { desc = "Previous git hunk" })
end

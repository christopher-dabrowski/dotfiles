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

  -- File Explorer (<leader>e)
  vim.keymap.set("n", "<leader>e", function()
    vscode.action("workbench.view.explorer")
  end, { desc = "Toggle Explorer" })

  -- Find Files (<leader>ff)
  vim.keymap.set("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
  end, { desc = "Find Files" })

  -- Git View (<leader>gg)
  vim.keymap.set("n", "<leader>gg", function()
    vscode.action("workbench.view.scm")
  end, { desc = "Git View" })

  -- Cllose other editors in group (<leader>bo)
  vim.keymap.set("n", "<leader>bo", function()
    vscode.action("workbench.action.closeOtherEditors")
  end, { desc = "Close Other Editors in Group" })

  -- Close editors in other groups (<leader>wo)
  vim.keymap.set("n", "<leader>wo", function()
    vscode.action("workbench.action.closeEditorsInOtherGroups")
  end, { desc = "Close Editors in Other Groups" })

  -- Split window vertically (<leader>wv)
  vim.keymap.set("n", "<leader>wv", function()
    vscode.action("workbench.action.splitEditorRight")
  end, { desc = "Split Window Vertically" })

  -- Word wrap toggle (<leader>uw)
  vim.keymap.set("n", "<leader>uw", function()
    vscode.action("editor.action.toggleWordWrap")
  end, { desc = "Toggle Word Wrap" })

  ------------------------------------------------
  -- Window Navigation (<leader>w...)
  ------------------------------------------------

  -- Focus left window (<leader>wh)
  vim.keymap.set("n", "<leader>wh", function()
    vscode.action("workbench.action.navigateLeft")
  end, { desc = "Focus Left Window" })

  -- Focus lower window (<leader>wj)
  vim.keymap.set("n", "<leader>wj", function()
    vscode.action("workbench.action.navigateDown")
  end, { desc = "Focus Lower Window" })

  -- Focus upper window (<leader>wk)
  vim.keymap.set("n", "<leader>wk", function()
    vscode.action("workbench.action.navigateUp")
  end, { desc = "Focus Upper Window" })

  -- Focus right window (<leader>wl)
  vim.keymap.set("n", "<leader>wl", function()
    vscode.action("workbench.action.navigateRight")
  end, { desc = "Focus Right Window" })

  -- Focus next window group (<leader>ww)
  vim.keymap.set("n", "<leader>ww", function()
    vscode.action("workbench.action.focusNextGroup")
  end, { desc = "Focus Next Window Group" })
end

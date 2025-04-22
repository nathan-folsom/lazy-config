-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

vim.keymap.set("n", "<C-/>", function()
  Util.terminal(nil, { border = "rounded", title = "Terminal", title_pos = "center" })
end, { desc = "Term with border" })

-- lazygit
-- Swap keymaps, I pretty much always use the cwd version
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>gG", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "Lazygit (Root Dir)" })
  vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
end

-- Add move to jumplist if there is a count
vim.keymap.set("n", "k", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })
vim.keymap.set("n", "j", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })

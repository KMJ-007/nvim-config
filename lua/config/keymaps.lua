-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit insert mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Use lowercase s for vim-surround in visual mode.
vim.keymap.set("x", "s", "<Plug>VSurround", { remap = true, desc = "Visual surround" })

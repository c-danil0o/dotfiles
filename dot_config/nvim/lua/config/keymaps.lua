-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map({ "n", "v", "c", "x" }, "H", "^", { desc = "Go to the beggining of the line" })
map({ "n", "v", "c", "x" }, "L", "$", { desc = "Go to the end of the line" })
-- redap d to delete without cut
map({ "n", "v" }, "d", '"_d')
map("n", "dd", '"_dd')
map("n", "dL", '"_d$')
-- remap c to change without cut
map("n", "c", '"_S')
map({ "n", "v" }, "D", '"_D')
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "c", '"_c')

-- remap m to delete with cut
map({ "n", "v" }, "m", "d")
map("n", "mm", "dd")

-- remap p to paste without yanking in v mode
map("v", "p", '"_dP')

vim.keymap.del({ "n", "x" }, ",")

map("n", ",", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

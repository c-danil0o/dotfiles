-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = augroup("kitty_mp"),
  callback = function()
    vim.cmd("if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=0 margin=0")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = augroup("kitty_mp"),
  callback = function()
    vim.cmd("if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=20 margin=0")
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("kitty_mp"),
  callback = function()
    vim.cmd("if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=0 margin=0")
  end,
})

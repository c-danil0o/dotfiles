-- Options are automatically loaded before lazy.nvim startup
if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_floating_corner_radius = 0.5
  vim.g.neovide_refresh_rate = 90
  vim.g.neovide_cursor_animation_length = 0.07
  vim.g.neovide_cursor_trail_size = 0.5
  -- vim.g.neovide_cursor_animate_in_insert_mode = false
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.1)
  end)
end
vim.g.snacks_animate = false
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.shiftwidth = 4 -- Size of an indent
vim.g.lazyvim_blink_main = true

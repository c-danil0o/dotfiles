local pending_oneshot = false

--- Enable / Disable / One-shots inline completion
---
--- @param oneshot boolean Optional oneshot parameter.
local function toggle_inline_completion(oneshot)
  local suggestion = require("supermaven-nvim.completion_preview")
  local binary = require("supermaven-nvim.binary.binary_handler")
  local preview = require("supermaven-nvim.completion_preview")
  local message = "Inline AI autocompletion "

  -- If inline completion is already on, we don't one-shot
  if oneshot and not suggestion.disable_inline_completion then
    return
  end

  if suggestion.disable_inline_completion then
    suggestion.disable_inline_completion = false
    vim.notify(message .. "ENABLED", vim.log.levels.INFO, { title = "SuperMaven" })

    local buffer = vim.api.nvim_get_current_buf()
    local file_name = vim.api.nvim_buf_get_name(buffer)

    binary:on_update(buffer, file_name, "cursor")
    binary:poll_once()

    if oneshot then
      pending_oneshot = true
    end
  else
    suggestion.disable_inline_completion = true
    vim.notify(message .. "DISABLED", vim.log.levels.INFO, { title = "SuperMaven" })

    preview:dispose_inlay()

    pending_oneshot = false
  end
end

local function accept_suggestion()
  local suggestion = require("supermaven-nvim.completion_preview")
  suggestion.on_accept_suggestion()
end

--- Potentially clears one-shot if one is pending
local function clear_oneshot()
  if pending_oneshot then
    local suggestion = require("supermaven-nvim.completion_preview")
    local preview = require("supermaven-nvim.completion_preview")

    pending_oneshot = false
    suggestion.disable_inline_completion = true
    preview:dispose_inlay()
  end
end

return {
  {
    "supermaven-inc/supermaven-nvim",
    keys = {
      {
        "<C-,>",
        function()
          toggle_inline_completion(true)
        end,
        desc = "One-shot Supermaven inlay completion",
        remap = true,
        mode = "i",
      },
      {
        "<C-CR>",
        function()
          accept_suggestion()
        end,
        desc = "Accept Supermaven suggestion",
        remap = true,
        mode = "i",
      },
    },
    config = function()
      require("supermaven-nvim").setup({
        disable_inline_completion = true, -- disables inline completion for use with cmp
        disable_keymaps = true, -- disables built in keymaps for more manual control
      })

      local suggestion = require("supermaven-nvim.completion_preview")
      local old_accept = suggestion.on_accept_suggestion

      -- Override the accept suggeston command to turn off one-shot
      ---@diagnostic disable-next-line: duplicate-set-field
      suggestion.on_accept_suggestion = function()
        old_accept()

        if pending_oneshot then
          suggestion.disable_inline_completion = true
          pending_oneshot = false
        end
      end

      -- Get the Supermaven autocmd group
      local augroup = vim.api.nvim_create_augroup("supermaven", { clear = false })
      --
      -- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      --   group = augroup,
      --   callback = clear_oneshot,
      -- })
      --
      -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      --   group = augroup,
      --   callback = clear_oneshot,
      -- })
      --
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        group = augroup,
        callback = clear_oneshot,
      })
    end,
  },
}

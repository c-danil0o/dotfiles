return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "Code Companion" },
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              -- api_key = "sk-af7f1fe2bdf6422eab59d5d55c75cd9f",
            },
            schema = {
              model = {
                default = "deepseek-chat",
              },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },
    })
    local M = require("lualine.component"):extend()

    M.processing = false
    M.spinner_index = 1

    local spinner_symbols = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    }
    local spinner_symbols_len = 10

    -- Initializer
    function M:init(options)
      M.super.init(self, options)

      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(request)
          if request.match == "CodeCompanionRequestStarted" then
            self.processing = true
          elseif request.match == "CodeCompanionRequestFinished" then
            self.processing = false
          end
        end,
      })
    end

    -- Function that runs every time statusline is updated
    function M:update_status()
      if self.processing then
        self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
        return spinner_symbols[self.spinner_index]
      else
        return nil
      end
    end

    return M
  end,
}

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>.", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "which_key_ignore" },
      { "<leader>/", vim.NIL },
    },
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}

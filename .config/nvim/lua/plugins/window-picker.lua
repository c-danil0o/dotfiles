return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
        filter_rules = {
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "NvimTree", "neo-tree", "notify", "noice" },

            -- if the file type is one of following, the window will be ignored
            buftype = { "terminal" },
          },

          -- filter using window options
          wo = {},

          -- if the file path contains one of following names, the window
          -- will be ignored
          file_path_contains = {},

          -- if the file name contains one of following names, the window will be
          -- ignored
          file_name_contains = {},
        },
      })
    end,
  },
}

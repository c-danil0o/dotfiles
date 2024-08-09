return {

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
}

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<A-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<A-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
  },
}

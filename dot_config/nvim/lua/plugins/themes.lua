return {

  -- { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "tiagovla/tokyodark.nvim" },
  { "notken12/base46-colors" },
  { "dgox16/oldworld.nvim", lazy = false, priority = 1000 },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyodark",
    },
  },
}

return {

  { "rebelot/kanagawa.nvim" },
  { "datsfilipe/vesper.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = false,
      color_overrides = {
        mocha = {
          mantle = "#0f111a",
          base = "#0e1017",
          crust = "#11131c",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "yorumi-abyss",
      colorscheme = "catppuccin-mocha",
    },
  },
}

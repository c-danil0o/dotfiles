return {

  { "rebelot/kanagawa.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#0f111a",
          mantle = "#0f111a",
          crust = "#0f111a",
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

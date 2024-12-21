return {
  {
    "krivahtoo/silicon.nvim",
    build = "./install.sh build",
    event = "VeryLazy",
    name = "silicon",
    config = function()
      require("silicon").setup({
        font = "Maple Mono NF=16",
        theme = "Monokai Extended",
        output = {
          -- (string) The full path of the file to save to.
          file = "",
          -- (boolean) Whether to copy the image to clipboard instead of saving to file.
          clipboard = false,
          -- (string) Where to save images, defaults to the current directory.
          --  e.g. /home/user/Pictures
          path = "/home/dc/Pictures/Code/",
          -- (string) The filename format to use. Can include placeholders for date and time.
          -- https://time-rs.github.io/book/api/format-description.html#components
          format = "code_[year][month][day]_[hour][minute][second].png",
        },
      })
    end,
  },
}

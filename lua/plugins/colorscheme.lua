return {
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      override = function(c)
        return {
          FloatBorder = { fg = c.base.dimmed3, bg = "NONE" },
          FloatTitle = { fg = c.base.dark },
          Comment = { fg = c.base.dimmed1 },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro",
    },
  },
}

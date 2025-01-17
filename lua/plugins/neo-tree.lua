return {
  {
    "neo-tree.nvim",
    init = function()
      require("neo-tree.command").execute({
        action = "show",
      })
    end,
    opts = {
      window = {},
    },
  },
}

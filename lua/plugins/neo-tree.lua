return {
  {
    "neo-tree.nvim",
    opts = {
      window = {},
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
    keys = {
      -- Swap root and cwd commands since I pretty much always use cwd
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
  },
}

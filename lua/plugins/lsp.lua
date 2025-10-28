return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          {
            "gd",
            function()
              require("telescope.builtin").lsp_references({ show_line = false })
            end,
          },
        },
      },
      flow = { enabled = true },
    },
  },
}

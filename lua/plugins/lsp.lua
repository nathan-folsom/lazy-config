return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          {
            "gr",
            function()
              require("telescope.builtin").lsp_references({ show_line = false })
            end,
          },
        },
      },
      flow = { enabled = true },
      sourcekit = {
        enabled = true,
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
          textDocument = {
            diagnostic = {
              dynamicRegistration = true,
              relatedDocumentSupport = true,
            },
          },
        },
      },
    },
  },
}

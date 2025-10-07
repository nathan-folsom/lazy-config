return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { biome = {} },
      setup = {
        biome = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "biome" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "typescript-tools" then
              client.server_capabilities.documentFormattingProvider = false
            elseif client.name == "eslint" then
              client.stop(true)
            end
          end)
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
              vim.lsp.buf.code_action({
                context = { only = { "source.fixAll.biome" } },
                apply = true,
              })
            end,
          })
        end,
      },
    },
  },
}

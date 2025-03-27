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
        end,
      },
    },
  },
}

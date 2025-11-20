return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { biome = {} },
      setup = {
        biome = function()
          Snacks.util.lsp.on(function(buf, client)
            if client.name == "biome" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "typescript-tools" or client.name == "ts_ls" then
              client.server_capabilities.documentFormattingProvider = false
            elseif client.name == "eslint" then
              client:stop(true)
            end
          end)
        end,
      },
    },
  },
}

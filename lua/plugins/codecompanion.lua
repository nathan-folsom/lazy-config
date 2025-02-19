return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "local_llama33",
        },
        inline = {
          adapter = "local_llama33",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:cat ~/.config/anthropic/api-key",
            },
          })
        end,
        local_llama33 = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "local_llama33",
            url = "${url}/",
            env = {
              url = "http://nate.local:8000",
            },
            schema = {
              model = {
                default = "default",
              },
            },
          })
        end,
      },
    },
  },
}

return {
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\<&].", register = { cr = false } },
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "%w.", register = { cr = false } },
        [">"] = { action = "close", pair = "<>", register = { cr = false } },
      },
    },
  },
}

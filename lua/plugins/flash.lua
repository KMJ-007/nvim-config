return {
  "folke/flash.nvim",
  ---@type flash.Config
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      mode = "fuzzy",
    },
    jump = {
      autojump = true,
    },
    label = {
      uppercase = false,
    },
    prompt = { prefix = { { "> " } } },
    modes = {
      char = { enabled = false },
      search = { enabled = false },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}

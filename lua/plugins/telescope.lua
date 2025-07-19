return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {},
      hidden = true,
    },
    pickers = {
      find_files = {
        hidden = true,
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
  },
}
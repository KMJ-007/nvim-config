return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
██╗  ██╗███╗   ███╗     ██╗      ██████╗  ██████╗ ███████╗
██║ ██╔╝████╗ ████║     ██║     ██╔═████╗██╔═████╗╚════██║
█████╔╝ ██╔████╔██║     ██║     ██║██╔██║██║██╔██║    ██╔╝
██╔═██╗ ██║╚██╔╝██║██   ██║     ████╔╝██║████╔╝██║   ██╔╝ 
██║  ██╗██║ ╚═╝ ██║╚█████╔╝     ╚██████╔╝╚██████╔╝   ██║  
╚═╝  ╚═╝╚═╝     ╚═╝ ╚════╝       ╚═════╝  ╚═════╝    ╚═╝  
        ]],
      },
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git" },
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = { ".git" },
        },
        projects = {
          paths = {
            "~/projects",
            "~/workspace",
          },
        },
      },
    },
  },
}
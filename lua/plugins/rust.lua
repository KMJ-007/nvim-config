return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cachePriming = {
                enable = false,
              },
              cargo = {
                allFeatures = false,
                allTargets = false,
                buildScripts = {
                  enable = false,
                },
              },
              checkOnSave = false,
              diagnostics = {
                enable = false,
              },
              procMacro = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}

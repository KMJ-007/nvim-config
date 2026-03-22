local M = {}

function M.get_mason_map()
  local mappings = require("mason-lspconfig").get_mappings()
  return {
    lspconfig_to_package = mappings.lspconfig_to_mason,
    package_to_lspconfig = mappings.mason_to_lspconfig,
  }
end

return M

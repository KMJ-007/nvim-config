local M = {}

function M.get(user_config)
  return require("catppuccin.special.bufferline").get_theme(user_config)()
end

return M

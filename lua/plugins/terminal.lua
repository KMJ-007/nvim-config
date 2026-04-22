local opencode_host = vim.env.NVIM_OPENCODE_HOST or "127.0.0.1"
local opencode_port = tonumber(vim.env.NVIM_OPENCODE_PORT) or 4096
local opencode_server_starting = false

local function opencode_server_url()
  return ("http://%s:%d"):format(opencode_host, opencode_port)
end

local function is_opencode_server_running()
  if vim.fn.executable("nc") ~= 1 then
    return false
  end

  return vim.system({ "nc", "-z", opencode_host, tostring(opencode_port) }):wait().code == 0
end

local function ensure_opencode_server(silent)
  if is_opencode_server_running() then
    return true
  end

  if vim.fn.executable("opencode") ~= 1 then
    if not silent then
      vim.notify("opencode is not installed or not on PATH", vim.log.levels.ERROR)
    end
    return false
  end

  if not opencode_server_starting then
    opencode_server_starting = true
    local ok, err = pcall(vim.system, {
      "opencode",
      "serve",
      "--hostname",
      opencode_host,
      "--port",
      tostring(opencode_port),
    }, { detach = true })

    if not ok then
      opencode_server_starting = false
      if not silent then
        vim.notify("Failed to start opencode server: " .. err, vim.log.levels.ERROR)
      end
      return false
    end
  end

  local ready = vim.wait(5000, is_opencode_server_running, 100)
  opencode_server_starting = false

  if not ready and not silent then
    vim.notify("Timed out waiting for opencode serve on " .. opencode_server_url(), vim.log.levels.ERROR)
  end

  return ready
end

local function is_running_terminal(buf)
  local ok, job_id = pcall(vim.api.nvim_buf_get_var, buf, "terminal_job_id")
  if not ok then
    return false
  end

  return vim.fn.jobwait({ job_id }, 0)[1] == -1
end

local function find_opencode_terminal()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
      local ok, is_opencode_terminal = pcall(vim.api.nvim_buf_get_var, buf, "opencode_terminal")
      if ok and is_opencode_terminal and is_running_terminal(buf) then
        return buf
      end
    end
  end
end

local function focus_opencode_terminal(buf)
  local win = vim.fn.bufwinid(buf)
  local splitright = vim.o.splitright

  local ok, err = pcall(function()
    if win ~= -1 then
      vim.api.nvim_set_current_win(win)
    else
      vim.o.splitright = true
      vim.cmd("belowright vsplit")
      vim.cmd.wincmd("l")
      vim.api.nvim_win_set_buf(0, buf)
    end

    vim.cmd.startinsert()
  end)

  vim.o.splitright = splitright

  if not ok then
    error(err)
  end
end

local function open_opencode_terminal()
  local existing = find_opencode_terminal()
  if existing then
    focus_opencode_terminal(existing)
    return
  end

  local command = table.concat({
    "opencode",
    "attach",
    "--dir",
    vim.fn.shellescape(vim.fn.getcwd()),
    vim.fn.shellescape(opencode_server_url()),
  }, " ")

  local splitright = vim.o.splitright
  local ok, err = pcall(function()
    vim.o.splitright = true
    vim.cmd("belowright vsplit")
    vim.cmd.wincmd("l")
    vim.cmd("terminal " .. command)
    vim.b.opencode_terminal = true
    vim.cmd.startinsert()
  end)

  vim.o.splitright = splitright

  if not ok then
    error(err)
  end
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<leader>tt]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local function set_terminal_keymaps()
        local terminal_opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], terminal_opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], terminal_opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], terminal_opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], terminal_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], terminal_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], terminal_opts)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = set_terminal_keymaps,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          ensure_opencode_server(true)
        end,
      })

      vim.api.nvim_create_user_command("Oc", function()
        if ensure_opencode_server(false) then
          open_opencode_terminal()
        else
          vim.notify("Falling back to direct opencode launch", vim.log.levels.WARN)
          local splitright = vim.o.splitright
          local ok, err = pcall(function()
            vim.o.splitright = true
            vim.cmd("belowright vsplit")
            vim.cmd.wincmd("l")
            vim.cmd("terminal opencode")
            vim.b.opencode_terminal = true
            vim.cmd.startinsert()
          end)

          vim.o.splitright = splitright

          if not ok then
            error(err)
          end
        end
      end, {
        desc = "Open or focus opencode in a vertical terminal split",
      })

      vim.cmd([[cnoreabbrev <expr> oc getcmdtype() == ':' && getcmdline() ==# 'oc' ? 'Oc' : 'oc']])
    end,
  },
}

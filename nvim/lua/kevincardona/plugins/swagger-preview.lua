local redocly_port = 3471
local redocly_url = "http://localhost:" .. redocly_port
local redocly_lock_file = "/tmp/redocly_preview.lock"

local function is_redocly_running()
  local f = io.open(redocly_lock_file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

local function write_lock_file()
  local f = io.open(redocly_lock_file, "w")
  if f then
    f:write("running")
    f:close()
  end
end

local function remove_lock_file()
  os.remove(redocly_lock_file)
end

function StartRedoclyPreview()
  if is_redocly_running() then
    print("Redocly preview is already running.")
    return
  end

  local file_path = vim.api.nvim_buf_get_name(0)
  local redocly_command = string.format("redocly preview-docs %s --port %d", file_path, redocly_port)
  vim.fn.jobstart(redocly_command, {detach = true})
  vim.fn.jobstart({"open", redocly_url}, {detach = true})  -- For macOS
  -- vim.fn.jobstart({"xdg-open", redocly_url}, {detach = true})  -- For Linux
  write_lock_file()
  print("Redocly preview started at " .. redocly_url)
end

function StopRedoclyPreview()
  if is_redocly_running() then
    vim.fn.jobstart("pkill -f 'redocly preview-docs'", {detach = true})
    remove_lock_file()
    print("Redocly preview stopped.")
  else
    print("No Redocly preview running.")
  end
end

function LintRedocly()
  local file_path = vim.api.nvim_buf_get_name(0)
  local redocly_command = string.format("redocly lint %s", file_path)
  local output = vim.fn.systemlist(redocly_command)
  print(table.concat(output, "\n"))
end

vim.api.nvim_set_keymap('n', '<leader>sp', ":lua StartRedoclyPreview()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss', ":lua StopRedoclyPreview()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sl', ":lua LintRedocly()<CR>", { noremap = true, silent = true })

return {}

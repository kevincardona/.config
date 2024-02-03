local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)

-- project navigation
vim.api.nvim_set_keymap('n', '<leader>e', ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- file navigation
vim.api.nvim_set_keymap('n', '<leader>ho', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>hb', ':lua require("harpoon.ui").nav_prev()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>nn', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bb', ':bprev<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pp', ':bprev<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>o', ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- window navigation
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap = true, silent = true})

-- prevent yank on delete
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true})
vim.api.nvim_set_keymap('n', 'X', '"_X', {noremap = true})

-- switch mode to ex
vim.api.nvim_set_keymap('n', '<leader>pv', ':Ex<CR>', {noremap = true, silent = true})

-- for 'change inside' or 'delete inside' operations
local ci_commands = { 'ci"', "ci'", "ci(", "ci)", "ci[", "ci]", "ci{", "ci}", "ci`", "di'", 'di"', "di(", "di)", "di[", "di]", "di{", "di}", "di`" }
for _, map in ipairs(ci_commands) do
  vim.api.nvim_set_keymap('n', map, '"_' .. map, {noremap = true})
end

return {}


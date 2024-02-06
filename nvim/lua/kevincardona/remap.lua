local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)

-- lsp
vim.api.nvim_set_keymap('n', '<leader>t', ":TroubleToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tq', ":TroubleToggle quickfix<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', function () require("trouble").next({skip_groups = true, jump = true}) end)
vim.keymap.set('n', '<leader>tp', function () require("trouble").previous({skip_groups = true, jump = true}) end)

-- project navigation
vim.api.nvim_set_keymap('n', '<leader>e', ":NvimTreeFindFileToggle!<CR>", { noremap = true, silent = true })

-- file navigation
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.api.nvim_set_keymap('n', '<leader>nn', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':bprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pp', ':bprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- preview file
vim.api.nvim_set_keymap('n', '<leader>md', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })

-- window navigation
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })

-- autocomplete
vim.api.nvim_set_keymap('n', '<leader>ac', ':Copilot panel<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>af', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- prevent yank on delete
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true })
vim.api.nvim_set_keymap('n', 'X', '"_X', { noremap = true })

-- for 'change inside' or 'delete inside' operations
local ci_commands = { 'ci"', "ci'", "ci(", "ci)", "ci[", "ci]", "ci{", "ci}", "ci`", "di'", 'di"', "di(", "di)", "di[",
    "di]", "di{", "di}", "di`" }
for _, map in ipairs(ci_commands) do
    vim.api.nvim_set_keymap('n', map, '"_' .. map, { noremap = true })
end

-- fun --
vim.api.nvim_set_keymap('n', '<leader>gu', ':CellularAutomaton make_it_rain<CR>', {noremap = true, silent = true})

return {}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.keymap.set("i", "jj", "<Esc>", opts)

-- lsp
map('n', '<leader>t', ":TroubleToggle<CR>", { noremap = true, silent = true })
map('n', '<leader>tq', ":TroubleToggle quickfix<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', function() require("trouble").next({ skip_groups = true, jump = true }) end)
vim.keymap.set('n', '<leader>tp', function() require("trouble").previous({ skip_groups = true, jump = true }) end)

-- project navigation
map('n', '<leader>e', ":NvimTreeFindFileToggle!<CR>", { noremap = true, silent = true })

-- file navigation
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
map('n', '<leader>nn', ':BufferNext<CR>', { noremap = true, silent = true })
map('n', '<leader>k', ':BufferNext<CR>', { noremap = true, silent = true })
map('n', '<leader>l', ':BufferNext<CR>', { noremap = true, silent = true })
map('n', '<leader>bb', ':BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<leader>pp', ':BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<leader>j', ':BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<leader>h', ':BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })
map('n', '<leader>o', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- preview file
map('n', '<leader>md', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })

-- window navigation
-- map('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
-- map('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })
-- map('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })
-- map('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })

-- autocomplete
map('n', '<leader>ac', ':Copilot panel<CR>', { noremap = true, silent = true })
map('n', '<leader>af', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- prevent yank on delete
map('n', 'd', '"_d', { noremap = true })
map('v', 'd', '"_d', { noremap = true })
map('n', 'x', '"_x', { noremap = true })
map('n', 'X', '"_X', { noremap = true })

-- for 'change inside' or 'delete inside' operations
local ci_commands = { 'ci"', "ci'", "ci(", "ci)", "ciw", "cw", "cil", "ci[", "ci]", "ci{", "ci}", "ci`", "di'", 'di"',
    "di(", "di)", "di[",
    "di]", "di{", "di}", "di`", "x" }
for _, map in ipairs(ci_commands) do
    vim.api.nvim_set_keymap('n', map, '"_' .. map, { noremap = true })
end

-- fun --
map('n', '<leader>gu', ':CellularAutomaton make_it_rain<CR>', { noremap = true, silent = true })

return {}

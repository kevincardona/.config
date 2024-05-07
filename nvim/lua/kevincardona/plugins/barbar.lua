-- show buffer list at the top of the window
return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',         -- for git status
        'nvim-tree/nvim-web-devicons',     -- for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        icons = {
            buffer_number = false,
        }
    },
    version = '^1.0.0',
    config = function ()
        require('barbar').setup()
        vim.keymap.set('n', '<leader>nn', ':BufferNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>k', ':BufferNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>l', ':BufferNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>bb', ':BufferPrevious<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>pp', ':BufferPrevious<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>j', ':BufferPrevious<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>h', ':BufferPrevious<CR>', { noremap = true, silent = true })
        -- vim.keymap.set('n', 'L', ':BufferNext<CR>', { noremap = true, silent = true })
        -- vim.keymap.set('n', 'H', ':BufferPrevious<CR>', { noremap = true, silent = true })
    end
}

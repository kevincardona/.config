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
            buffer_number = true,
        }
    },
    version = '^1.0.0',
}

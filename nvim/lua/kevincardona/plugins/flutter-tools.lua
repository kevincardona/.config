vim.keymap.set('n', '<leader>fld', ":FlutterVisualDebug<CR>")
vim.keymap.set('n', '<leader>fls', ":FlutterRun<CR>")
vim.keymap.set('n', '<leader>flr', ":FlutterReload<CR>")
vim.keymap.set('n', '<leader>flq', ":FlutterQuit<CR>")
vim.keymap.set('n', '<leader>flf', ":FlutterLspRestart<CR>")
vim.keymap.set('n', '<leader>flo', ":FlutterOutlineToggle<CR>")

return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',     -- optional for vim.ui.select
    },
    config = true,
}

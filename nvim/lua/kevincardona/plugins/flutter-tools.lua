vim.keymap.set('n', 'fld', ":FlutterVisualDebug<CR>")
vim.keymap.set('n', 'flr', ":FlutterRun<CR>")
vim.keymap.set('n', 'flq', ":FlutterQuit<CR>")
vim.keymap.set('n', 'flf', ":FlutterLspRestart<CR>")
vim.keymap.set('n', 'flo', ":FlutterOutlineToggle<CR>")

return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',     -- optional for vim.ui.select
    },
    config = true,
}

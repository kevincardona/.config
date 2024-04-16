require("lazy").setup({
    'petertriho/nvim-scrollbar',
    'folke/tokyonight.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-tree.lua',
    'tpope/vim-fugitive',
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    'mbbill/undotree',
    'github/copilot.vim',
    'christoomey/vim-tmux-navigator',
    'folke/trouble.nvim',
    'folke/which-key.nvim',
    'ahmedkhalf/project.nvim',
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require('mason').setup {
                lspconfig = true,
            }
            require('mason-lspconfig').setup()
            require("mason-lspconfig").setup_handlers {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end
            }
        end
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require('onedark').setup {
                style = 'darker', -- dark, darker, cool, deep, warm, warmer, light
            }
            require('onedark').load()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
                cmdheight = 0
            },
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        -- adds git signs to gutter
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map('n', '<leader>hb', function()
                    gs.blame_line { full = true }
                end, { desc = 'git blame line' })
                map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
                map('n', '<leader>hD', function()
                    gs.diffthis '~'
                end, { desc = 'git diff against last commit' })

                -- toggles
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
                map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
            end,
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- for git status
            'nvim-tree/nvim-web-devicons', -- for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            icons = {
                buffer_number = true,
            }
        },
        version = '^1.0.0',
    },
    -- fuzzy finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
    {
        -- highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    { import = 'kevincardona.plugins' },
})

require("lazy").setup({
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
    'eandrju/cellular-automaton.nvim',
    'folke/which-key.nvim',
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
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
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
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- 'nvim-telescope/telescope-project.nvim',
    'ahmedkhalf/project.nvim',
    {
        -- highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    -- lsp zero configs, nothing to do here
    -- no need to go any lower
    -- just scroll up from here
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            lazy = true,
            config = false,
            init = function()
                -- Disable automatic setup, we are doing it manually
                vim.g.lsp_zero_extend_cmp = 0
                vim.g.lsp_zero_extend_lspconfig = 0
            end,
        },
        {
            'williamboman/mason.nvim',
            lazy = false,
            config = true,
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                { 'L3MON4D3/LuaSnip' },
            },
            config = function()
                -- Here is where you configure the autocompletion settings.
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_cmp()

                -- And you can configure cmp even more, if you want to.
                local cmp = require('cmp')
                local cmp_action = lsp_zero.cmp_action()

                cmp.setup({
                    formatting = lsp_zero.cmp_format(),
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<S-CR>'] = cmp.mapping.confirm(),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    })
                })
            end
        },

        -- LSP
        {
            'neovim/nvim-lspconfig',
            cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
                'folke/neodev.nvim',
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'williamboman/mason-lspconfig.nvim' },
            },
            config = function()
                -- This is where all the LSP shenanigans will live
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_lspconfig()

                --- if you want to know more about lsp-zero and mason.nvim
                --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
                lsp_zero.on_attach(function(client, bufnr)
                    -- see :help lsp-zero-keybindings
                    -- to learn the available actions
                    lsp_zero.default_keymaps({ buffer = bufnr })
                    local nmap = function(keys, func, desc)
                        if desc then
                            desc = 'LSP: ' .. desc
                        end

                        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                    end

                    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                        '[W]orkspace [S]ymbols')

                    -- See `:help K` for why this keymap
                    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

                    -- Lesser used LSP functionality
                    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                    nmap('<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, '[W]orkspace [L]ist Folders')

                    -- Create a command `:Format` local to the LSP buffer
                    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                        vim.lsp.buf.format()
                    end, { desc = 'Format current buffer with LSP' })
                    vim.opt.signcolumn = "yes"

                    vim.api.nvim_create_autocmd("FileType", {
                        pattern = "ruby",
                        callback = function()
                            vim.lsp.start {
                                name = "rubocop",
                                cmd = { "bundle", "exec", "rubocop", "--lsp" },
                            }
                        end,
                    })

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        pattern = "*.rb",
                        callback = function()
                            vim.lsp.buf.format()
                        end,
                    })
                end)

                 -- Set up lspconfig.
              local capabilities = require('cmp_nvim_lsp').default_capabilities()
              -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
              require('lspconfig')['rubocop'].setup  { capabilities = capabilities }
              require('lspconfig')['html'].setup        { capabilities = capabilities }
              require('lspconfig')['cssls'].setup       { capabilities = capabilities }
              require('lspconfig')['tsserver'].setup    { capabilities = capabilities }
              require('lspconfig')['eslint'].setup      { capabilities = capabilities }
              require('lspconfig')['ls_lua'].setup { capabilities = capabilities }

                require('mason-lspconfig').setup({
                    ensure_installed = {},
                    handlers = {
                        lsp_zero.default_setup,
                        lua_ls = function()
                            -- (Optional) Configure lua language server for neovim
                            local lua_opts = lsp_zero.nvim_lua_ls()
                            require('lspconfig').lua_ls.setup(lua_opts)
                        end,
                    }
                })
            end
        }
    },
    { import = 'kevincardona.plugins' },
})

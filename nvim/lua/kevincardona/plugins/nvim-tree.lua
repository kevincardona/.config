-- file explorer because i dont like ex
return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            end

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                update_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                actions = {
                    change_dir = { enable = false }
                },
            })
        end
    }
}

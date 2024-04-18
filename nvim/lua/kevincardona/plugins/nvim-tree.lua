-- file explorer because i dont like ex
return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                vim.keymap.set('n', '<LeftRelease>', function()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                        api.node.open.edit()
                    end
                end, {})

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            end

            require("nvim-tree").setup({
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
                }
            })
        end
    }
}

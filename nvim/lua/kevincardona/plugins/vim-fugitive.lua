-- some helpful git stuff
return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb",
        "shumphrey/fugitive-gitlab.vim",
    },
    config = function()
        vim.g.fugitive_gitlab_domains = {
            ["gitlab.vailsys.com"] = "gitlab.com",
        }
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gb", ":GBrowse<CR>", opts);

        local kevin_fugitive = vim.api.nvim_create_augroup("kevin_fugitive", {})
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = kevin_fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end
                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({ 'pull', '--rebase' })
                end, opts)
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
            end,
        })

        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}

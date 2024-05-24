return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal/",
      },
      {
        name = "work",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/work/",
      },
    },
  },

  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal/",
        },
        {
          name = "work",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/work/",
        },
      },
    })
    vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ot', ':ObsidianToday<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>oy', ':ObsidianYesterday<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>op', ':ObsidianQuickSwitch<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ov', ':ObsidianWorkspace<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ow', ':ObsidianWorkspace<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>of', ':ObsidianSearch<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>od', ':ObsidianDailies<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ol', ':ObsidianLinks<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>oo', ':ObsidianOpen<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ogd', ':ObsidianFollowLink<CR>', { noremap = true, silent = true })
  end,
}

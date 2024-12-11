-- editor config ---------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- keybindings -----------------------------------------------------------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- bootstrap lazy.nvim ---------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugings --------------------------------------------------------------------
require("lazy").setup({
    "nvim-lualine/lualine.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mbbill/undotree",
    --"preservim/nerdtree",
    "akinsho/toggleterm.nvim",
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    "LnL7/vim-nix",
    {
        {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},

        --- Uncomment these if you want to manage LSP servers from neovim
        -- {'williamboman/mason.nvim'},
        -- {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
            },
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                {'L3MON4D3/LuaSnip'},
            }
        }
    }
})

-- plugins configurations ------------------------------------------------------

-- color theme
vim.cmd[[colorscheme tokyonight]]

-- lualine
require('lualine').setup {
    options = {
        theme = 'tokyonight',
    },
}

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- treesitter
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- undotree 
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- nerdtree
--vim.keymap.set("n", "<leader>n", ":NERDTreeFocus<CR>")
--vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<CR>")

-- toggleterm
require'toggleterm'.setup {
    direction = "float",
    open_mapping = [[<C-t>]],
}
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

-- lsp-zero
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

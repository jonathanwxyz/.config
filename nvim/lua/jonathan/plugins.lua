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

local plugins = {
    -- plenary
    "nvim-lua/plenary.nvim",
    -- telescope
    "nvim-telescope/telescope.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function() require("telescope").load_extension("fzf") end
    },
    -- treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/playground" },
    -- lsp
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "dev-v3",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-cmdline" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        }
    },
    --[[ -- cmp pictogram in autocomplete
  "onsails/lspkind.nvim" ]]

    -- git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    "tpope/vim-fugitive",

    -- harpoon
    "ThePrimeagen/harpoon",

    -- commenting helper
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end
    },

    -- theming
    "navarasu/onedark.nvim",
    "nvim-lualine/lualine.nvim",
    -- devicons
    "nvim-tree/nvim-web-devicons",

    -- undotree
    "mbbill/undotree",

    -- remember my mappings!
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to the default settings
                -- refer to the configuration section below
            }
        end
    },
}
local opts = {}

require("lazy").setup(plugins, opts)

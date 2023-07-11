local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
end

return require("packer").startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  -- plenary
  use "nvim-lua/plenary.nvim"
  -- telescope
  use "nvim-telescope/telescope.nvim"
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make",
        requires = {"nvim-telescope/telescope.nvim"},
        config = function() require("telescope").load_extension("fzf") end}
  -- treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/playground"}
  -- lsp
  use {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"saadparwaiz1/cmp_luasnip"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lua"},

      -- Snippets
      {"L3MON4D3/LuaSnip"},
      {"rafamadriz/friendly-snippets"},
    }
  }
  --[[ -- cmp pictogram in autocomplete
  use "onsails/lspkind.nvim" ]]

  -- git
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  use "tpope/vim-fugitive"

  -- harpoon
  use "ThePrimeagen/harpoon"

  -- commenting helper
  use {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  }

  -- theming
  use "navarasu/onedark.nvim"
  use "nvim-lualine/lualine.nvim"
  -- devicons
  use "nvim-tree/nvim-web-devicons"

  -- undotree
  use("mbbill/undotree")

  -- remember my mappings!
  use {
   "folke/which-key.nvim",
   config = function()
     require("which-key").setup {
       -- your configuration comes here
       -- or leave it empty to use the default settings
       -- refer to the configuration section below
     }
    end
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

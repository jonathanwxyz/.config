-- options
vim.opt.showmatch = true              -- show matching brackets
vim.opt.ignorecase = true              -- case insensitive searching
vim.opt.smartcase = true
vim.opt.hlsearch = false               -- highlight search

vim.opt.tabstop = 4               -- number of columns occupied by a tab
vim.opt.softtabstop = 4           -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.expandtab = true               -- converts tabs to white space
vim.opt.shiftwidth = 4            -- width for autoindents
vim.opt.smartindent = true

-- vim.opt.wildmode = longest,list   -- get bash-like tab completions
vim.opt.mouse = "a"                 -- enable mouse click
-- vim.opt.clipboard = "unnamedplus"   -- using system clipboard

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"      -- set an 80 column border for good coding style
vim.opt.termguicolors = true
vim.opt.cursorline = true              -- highlight current cursorline

-- open new split panes to right and below
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
vim.opt.undofile = true

vim.cmd [[
filetype plugin on
filetype plugin indent on   " allow auto-indenting depending on file type, apparently enabled by default
]]

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

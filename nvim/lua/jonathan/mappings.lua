local map = vim.keymap.set

-- Find files using Telescope command-line sugar.
local builtin = require('telescope.builtin')
map("n", "<leader>ff", builtin.find_files, {desc = "Find Files"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- map("n", "<leader>fg", builtin.git_files, {desc = "Find Git Files"})
map("n", "<leader>fs", builtin.grep_string, {desc = "Grep String"})
map("n", "<leader>fb", builtin.buffers, {desc = "Find Buffers"})
map("n", "<leader>fh", builtin.help_tags, {desc = "Help Tags"})

-- open netrw
map("n", "<leader>e", vim.cmd.Rex, {desc = "Toggle Netrw"})

-- copy paste mappings
map("x", "<leader>p", "\"_dP")
map({"n", "v"}, "<leader>y", "\"+y")
map({"n", "v"}, "<leader>d", "\"_d")

-- git
map("n", "<leader>gs", vim.cmd.Git, {desc = "Git Status"});
map("n", "<leader>ga", "<cmd>Git fetch --all<CR>", {desc = "Git Fetch All"});

-- move line or visually selected block - alt+j/k
-- ?
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Harpoon Mappings
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
map("n", "<leader>a", mark.add_file, {desc = "Add to Harpoon"})
map("n", "<C-e>", ui.toggle_quick_menu, {desc = "Manage Harpoon"})
map("n", "<C-j>", function() ui.nav_file(1) end)
map("n", "<C-k>", function() ui.nav_file(2) end)
map("n", "<C-l>", function() ui.nav_file(3) end)
map("n", "<C-;>", function() ui.nav_file(4) end)

-- UndoTree
map("n", "<F5>", vim.cmd.UndotreeToggle)

map("n", "<C-f>", vim.lsp.buf.format)

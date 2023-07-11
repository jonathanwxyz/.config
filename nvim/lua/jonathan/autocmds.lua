local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Go to the last position when reopening a file
local group = augroup("GoToLastPosition", { clear = true })
autocmd("BufReadPost", { callback = function()
    local line = vim.fn.line
    local lastPos = line("'\"")
    if lastPos > 0 and lastPos <= line("$") then
        vim.api.nvim_win_set_cursor(0, { lastPos, 0 })
    end
end, group = group})

-- Create new directories if they don't already exist
local group = augroup("MkDir", { clear = true })
autocmd("BufWritePre", { callback = function()
    local mkdir = vim.fn.mkdir
    local expand = vim.fn.expand
    mkdir(expand("<afile>:p:h"), "p")
end, group = group})

-- Turns on the spell checker for markdown files
local group = augroup("Spell", { clear = true })
autocmd("FileType", {
    pattern = {"markdown", "tex"},
    callback = function()
        vim.cmd[[set spell spelllang=en_gb]]
        -- vim.opt.spell = true
    end,
    group = group
})

vim.cmd([[autocmd BufWritePost *.tex silent! execute "!pdflatex --shell-escape % >/dev/null 2>&1" | redraw!]])
-- local group = augroup("TexAutoCompile", {clear = true})
-- autocmd({"BufWritePost"}, {
--     pattern = "tex",
--     command = "!pdflatex --shell-escape % >/dev/null 2>&1",
--     group = group,
-- })

local group = augroup("RemoveWhitespace", {clear = true})
autocmd({"BufWritePre"}, {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = group,
})
-- need to implement eslint format on save
--[[ local group = vim.api.nvim_create_augroup("EslintFixAll", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "markdown",
    callback = function()
        vim.opt.spell = true
    end,
    group = group
}) ]]

-- vim.cmd[[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = {preserve_mappings = false},
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.set_preferences({
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
})

lsp.ensure_installed({
    "tsserver",
    "eslint",
    "pyright",
    "clangd",
    "rust_analyzer",
    "gopls",
    "lua_ls"
})

lsp.setup_nvim_cmp({
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
})

lsp.nvim_workspace()


lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {buffer = bufnr, remap = true})
end)

local lsp_util = require("lspconfig").util
lsp.configure("denols", {
    root_dir = lsp_util.root_pattern("deno.json", "deno.jsonc"),
})

lsp.configure("tsserver", {
  root_dir = lsp_util.root_pattern("package.json, tsconfig.json"),
  single_file_support = false
})

lsp.setup()

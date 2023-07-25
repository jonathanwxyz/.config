local lsp = require("lsp-zero").preset({})

lsp.set_sign_icons({
    error = "",
    warn = "",
    hint = "",
    info = ""
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false
    })
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = bufnr, remap = true })
end)

lsp.format_mapping("ff", {
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ["lua_ls"] = { "lua" },
        ["rust_analyzer"] = { "rust" },
        ["gopls"] = { "go" },
        ["clangd"] = { "c", "c++" },
        ["pyright"] = { "python" },
        ["eslint"] = { "javascript", "typesript" },
    }
})

-- Set up cmp
require("lsp-zero").extend_cmp()

local cmp = require("cmp")
-- local cmp_action = require("lsp-zero").cmp_action()

-- load external snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
})

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "tsserver",
        "eslint",
        "pyright",
        "clangd",
        "rust_analyzer",
        "gopls",
        "lua_ls"
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
        end,
    },
})

-- local lsp_util = require("lspconfig").util
-- lsp.configure("denols", {
--     root_dir = lsp_util.root_pattern("deno.json", "deno.jsonc"),
-- })
--
-- lsp.configure("tsserver", {
--   root_dir = lsp_util.root_pattern("package.json, tsconfig.json"),
--   single_file_support = false
-- })

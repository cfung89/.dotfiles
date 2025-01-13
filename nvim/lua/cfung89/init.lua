require("cfung89.options")
require("cfung89.keymaps")
require("cfung89.lazy_init")

require('lazy').setup({
    spec = 'cfung89.plugins',
    checker = {
        enabled = true,
        notify = true
    }
})

-- local augroup = vim.api.nvim_create_augroup
-- local LSPGroup = augroup("Config", {})

-- autocmd('LspAttach', {
--     group = LSPGroup,
--     callback = function(e)
--         local opts = { buffer = e.buf }
--         vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--         vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--         vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--         vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--         vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--         vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--         vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--         vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--         vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--         vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     end
-- })

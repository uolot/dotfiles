-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')

local on_lsp_attach = function(client, buffer)
    -- ufo
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- -- local capabilities = requite('cmp_nvim_lsp').default_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --     dynamicRegistration = false,
    --     lineFoldingOnly = true,
    -- }
    -- client.capabilities = capabilities
    -- ufo end


    -- TODO: update capabilities with `require('cmp_nvim_lsp').update_capabilities
    if client.supports_method('textDocument/formatting') then
        require('lsp-zero').buffer_autoformat()
        -- require("lsp-format").on_attach(client)
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(buffer, false)
    end
end

-- TODO: remove
local on_tsserver_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- if client.server_capabilities.inlayHintProvider then
    --     vim.lsp.inlay_hint(bufnr, false)
    -- end

    -- on_lsp_attach(client, bufnr)
end

local lsputils_border_chars = {
    TOP_LEFT = '┌',
    TOP_RIGHT = '┐',
    MID_HORIZONTAL = '─',
    MID_VERTICAL = '│',
    BOTTOM_LEFT = '└',
    BOTTOM_RIGHT = '┘',
}

vim.g.lsp_utils_location_opts = {
    preview = {
        border = true,
        border_chars = lsputils_border_chars,
    }
}

vim.g.lsp_utils_symbols_opts = {
    preview = {
        border = true,
        border_chars = lsputils_border_chars,
    }
}

vim.g.lsp_utils_codeaction_opts = {
    preview = {
        border = true,
        border_chars = lsputils_border_chars,
    }
}

-- LSP borders
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = 'rounded'
    }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "rounded"
    }
)

-- nvim-lsp-installer
-- https://github.com/williamboman/nvim-lsp-installer#setup
-- local function filter(arr, fn)
--     if type(arr) ~= "table" then
--         return arr
--     end
--
--     local filtered = {}
--     for k, v in pairs(arr) do
--         if fn(v, k, arr) then
--             table.insert(filtered, v)
--         end
--     end
--
--     return filtered
-- end

-- local function filterDTS(value)
--     return string.match(value.uri, '%.d.ts') == nil
--     -- return string.match(value.targetUri, '%.d.ts') == nil
-- end

-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.on_server_ready(function(server)
--     local opts = {
--         on_attach = on_lsp_attach,
--         flags = {
--             -- This will be the default in neovim 0.7+
--             debounce_text_changes = 150,
--         },
--     }
--
--     local signs = { Hint = "", Info = "", Warn = "", Error = "" }
--     for type, icon in pairs(signs) do
--         local hl = "DiagnosticSign" .. type
--         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--     end
--
--     if server.name == "tsserver" then
--         opts.on_attach = on_tsserver_attach
--         -- opts.on_attach = on_lsp_attach
--         -- opts.handlers = {
--         --     ["textDocument/definition"] = function (error, result, method, ...)
--         --         -- if not vim.tbl_islist(result) or type(result) ~= "table" then
--         --         --     return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
--         --         -- end
--         --         --
--         --         -- return vim.lsp.handlers["textDocument/definition"](err, { result[1] }, method, ...)
--         --
--         --         -- vim.notify(vim.inspect(result))
--         --         if (vim.tbl_islist(result) or type(result) == "table") and #result > 1 then
--         --             local filtered_result = filter(result, filterDTS)
--         --             -- vim.notify(vim.inspect(filtered_result))
--         --             return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
--         --         end
--         --
--         --         return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
--         --     end
--         -- }
--     end
--
--     server:setup(opts)
-- end)

-- local lspconfig = require('lspconfig')
-- lspconfig.tsserver.setup { on_attach = on_attach }
--
require("null-ls").setup()
require("mason-null-ls").setup({
    --     -- ensure_installed = {"prettier", "eslint-lsp"},
    automatic_installation = true,
    --     automatic_setup = true,
})

require("mason").setup()

require("mason-lspconfig").setup({
    -- ensure_installed = {
    --     'tsserver',
    --     'eslint',
    --     -- 'prettier',
    -- }
})

local lsp = require('lsp-zero')
-- lsp.set_sign_icons()
lsp.extend_lspconfig({
    set_lsp_keymaps = false,
    on_attach = on_lsp_attach,
    capabilities = {
        textDocument = {
            foldingRange = { -- ufo
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
        }
    }
})
-- local lsp = require('lsp-zero').preset({})
-- lsp.on_attach(function(client, bufnr)
--   -- lsp.default_keymaps({buffer = bufnr})
-- end)
-- lsp.setup()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            -- on_attach = on_lsp_attach
        })
    end,
    ['tsserver'] = function()
        lspconfig.tsserver.setup({
            on_attach = on_tsserver_attach,
            settings = {
                completions = {
                    -- completeFunctionCalls = true
                },
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                }
            }
        })
    end
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
}

-- adjust virtual text severity
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- signs = {
        --     severity_limit = 'Warning',
        -- },
        virtual_text = {
            severity_limit = 'Warning',
        },
    }
)

-- smjonas/inc-rename.nvim
require('inc_rename').setup()

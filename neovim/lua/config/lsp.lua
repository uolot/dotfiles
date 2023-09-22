-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig

local on_lsp_attach = function(client, buffer)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(buffer, false)
    end
end

local on_tsserver_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
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

local enhanced_float_handler = require('config.enhanced_float_handler')

-- LSP borders
vim.lsp.handlers["textDocument/signatureHelp"] = enhanced_float_handler(vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = 'rounded'
    }
))

vim.lsp.handlers["textDocument/hover"] = enhanced_float_handler(vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "rounded"
    }
))

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

local lspconfig = require('lspconfig')

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
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
            },

            -- davidosomething/format-ts-errors.nvim
            handlers = {
                ["textDocument/publishDiagnostics"] = function(
                    _,
                    result,
                    ctx,
                    config
                )
                    if result.diagnostics == nil then
                        return
                    end

                    -- ignore some tsserver diagnostics
                    local idx = 1
                    while idx <= #result.diagnostics do
                        local entry = result.diagnostics[idx]

                        local formatter = require('format-ts-errors')[entry.code]
                        entry.message = formatter and formatter(entry.message) or entry.message

                        -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                        if entry.code == 80001 then
                            -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                            table.remove(result.diagnostics, idx)
                        else
                            idx = idx + 1
                        end
                    end

                    vim.lsp.diagnostic.on_publish_diagnostics(
                        _,
                        result,
                        ctx,
                        config
                    )
                end,
            },
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

-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig

local on_tsserver_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

local on_lsp_attach = function(client, buffer)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(buffer, false)
    end
    if client.name == 'typescript-tools' then
        on_tsserver_attach(client, buffer)
    end
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
    -- ['tsserver'] = function()
    --     lspconfig['tsserver'].setup({
    --         on_attach = on_tsserver_attach,
    --     })
    -- end

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

require("typescript-tools").setup({
    on_attach = on_tsserver_attach,
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
                -- entry.message = require('better-ts-errors.parser').prettify_string(entry.message)

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
    settings = {
        -- TODO: temporary
        tsserver_logs = "normal",
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = true,
        -- "change"|"insert_leave" determine when the client asks the server about diagnostic
        publish_diagnostic_on = "insert_leave",
        -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
        -- "remove_unused_imports"|"organize_imports") -- or string "all"
        -- to include all supported code actions
        -- specify commands exposed as code_actions
        -- expose_as_code_action = {},
        -- expose_as_code_action = "all",
        expose_as_code_action = { "fix_all", "organize_imports" },
        -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
        -- not exists then standard path resolution strategy is applied
        tsserver_path = nil,
        -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
        -- (see 💅 `styled-components` support section)
        tsserver_plugins = {
            "@monodon/typescript-nx-imports-plugin",
        },
        -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
        -- memory limit in megabytes or "auto"(basically no limit)
        tsserver_max_memory = "auto",
        -- Defaults: https://github.com/pmizio/typescript-tools.nvim/blob/master/lua/typescript-tools/config.lua#L17
        -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
        tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            -- new
            quotePreference = "auto",
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            -- <!--
            includeCompletionsWithSnippetText = true,
            includeAutomaticOptionalChainCompletions = true,
            includeCompletionsWithClassMemberSnippets = true,
            includeCompletionsWithObjectLiteralMethodSnippets = true,
            -- -->
            -- "shortest" | "project-relative" | "relative" | "non-relative"
            importModuleSpecifierPreference = "project-relative",
            allowRenameOfImportPath = true,
        },
        -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
        tsserver_format_options = {},
        code_lens = "all",
        disable_member_code_lens = true,
        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
        complete_function_calls = false,
        include_completions_with_insert_text = true,
    },

})

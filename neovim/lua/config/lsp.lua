-- Quick jump:
-- servers

-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig

local dependencies = {
    "folke/neodev.nvim",
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            pip = { upgrade_pip = true },
            ui = { border = "rounded" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {},
    },
    -- "VonHeikemen/lsp-zero.nvim",
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        },
        config = require("plugins.null-ls").config,
    },
}

local function config()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
            local function client_supports_method(client, method, bufnr)
                if vim.fn.has 'nvim-0.11' == 1 then
                    return client:supports_method(method, bufnr)
                else
                    return client.supports_method(method, { bufnr = bufnr })
                end
            end

            local client = vim.lsp.get_client_by_id(event.data.client_id)

            if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd('LspDetach', {
                    group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                    callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                    end,
                })
            end

            if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })

                local function toggle_inlay_hints(bufnr)
                    local enable = not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                    vim.lsp.inlay_hint.enable(enable, { bufnr = bufnr })
                    if enable then
                        vim.notify("Enabled inlay hints")
                    else
                        vim.notify("Disabled inlay hints")
                    end
                end

                require("which-key").add({ { "<Leader>xi", function() toggle_inlay_hints(event.buf) end, desc = "Inlay hints" } })
            end
        end
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- ufo
    capabilities = vim.tbl_deep_extend('force', capabilities, {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        }
    })
    -- blink-cmp
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities(capabilities))

    local servers = {
        -- server = {
        --   cmd = {...},
        --   filetypes = {...},
        --   capabilities = {...},
        -- }

        arduino_language_server = {},
        astro = {},
        bashls = {},
        cssls = {},
        docker_compose_language_service = {},
        dockerls = {},
        emmet_ls = {
            filetypes = {
                "astro",
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "svelte",
                "pug",
                "typescriptreact",
                "vue",
            },
        },
        eslint = {},
        jedi_language_server = {},
        jsonls = {},
        lemminx = {},
        lua_ls = {},
        marksman = {},
        ruff = {},
        sqlls = {},
        svelte = {},
        tailwindcss = {},
        taplo = {},
        typos_lsp = {},
        vimls = {},
        volar = {},
        yamlls = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    -- vim.list_extend(ensure_installed, { "stylua" })

    require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end
        }
    })

    local on_tsserver_attach = function(client, bufnr)
        require("twoslash-queries").attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    require("typescript-tools").setup({
        handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx)
                require("ts-error-translator").translate_diagnostics(err, result, ctx)
                vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
            end,
        },
        on_attach = on_tsserver_attach,
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
                -- "@monodon/typescript-nx-imports-plugin",
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
                -- importModuleSpecifierPreference = "project-relative",
                importModuleSpecifierPreference = "non-relative",
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
end

return {
    dependencies = dependencies,
    config = config,
}

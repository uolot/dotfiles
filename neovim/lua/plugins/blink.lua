-- TOC:
-- appearance
-- sources

local dependencies = {
    "rafamadriz/friendly-snippets",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    {
        "stevearc/vim-vscode-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    'disrupted/blink-cmp-conventional-commits',
    {
        "fang2hou/blink-copilot",
        dependencies = { "zbirenbaum/copilot.lua" },
        opts = {
            kind_icon = "",
        },
    },
}

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
    -- enabled = function() return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype) end,
    enabled = function() return not vim.tbl_contains({ "copilot-chat" }, vim.bo.filetype) end,

    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    -- keymap = { preset = 'default' },
    keymap = {
        preset = 'enter',
        ['<Right>'] = { 'accept', 'fallback' },
    },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = 'mono',
    },

    completion = {
        keyword = { range = 'full' }, -- or 'prefix'
        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = false, auto_insert = true } },
        accept = { auto_brackets = { enabled = false }, },
        menu = {
            -- auto_show = false,
            draw = {
                columns = {
                    {
                        "label",
                        "label_description",
                        gap = 1,
                    },
                    {
                        "kind_icon",
                        "kind",
                        "source_name",
                        gap = 1,
                    }
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        ghost_text = {
            -- enabled = true,
            show_with_menu = true,
        },
    },

    signature = {
        enabled = true,
    },

    snippets = { preset = "luasnip" },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = {
            'conventional_commits',
            'lsp',
            'buffer',
            'path',
            'snippets',
            'copilot',
            'lazydev',
            -- 'omni',
        },
        providers = {
            -- By default, the buffer source will only show when the LSP source returns no items. Enable always showing the buffer source.
            lsp = {
                fallbacks = {},
            },
            path = {
                opts = {
                    get_cwd = function(_) return vim.fn.getcwd() end,
                },
            },
            conventional_commits = {
                name = 'Conventional Commits',
                module = 'blink-cmp-conventional-commits',
                enabled = function()
                    return vim.bo.filetype == 'gitcommit'
                end,
                ---@module 'blink-cmp-conventional-commits'
                ---@type blink-cmp-conventional-commits.Options
                opts = {}, -- none so far
            },
            copilot = {
                name = "Copilot",
                module = "blink-copilot",
                score_offset = 1,
                async = true,
            },
            snippets = {
                score_offset = -3,
            },
        },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        use_frecency = true,
        use_proximity = true,
        sorts = {
            function(a, b)
                if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
                    return
                end
                return b.client_name == 'emmet_ls' or b.client_name == 'copilot'
            end,
            -- default sorts
            'exact',
            'score',
            'sort_text',
        },
    },

    cmdline = {
        keymap = {
            ['<Tab>'] = { 'show', 'accept' },
            -- ['<Up>'] = { 'select_prev', 'fallback' },
            -- ['<Down>'] = { 'select_next', 'fallback' },
            ['<Right>'] = { 'select_and_accept' },
        },
        completion = {
            menu = { auto_show = true },
        },
    },
}

return {
    dependencies = dependencies,
    opts = opts,
}

local dependencies = { 'rafamadriz/friendly-snippets' }

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
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
    keymap = { preset = 'enter' },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
    },

    completion = {
        keyword = { range = 'full' }, -- or 'prefix'
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

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            path = {
                opts = {
                    get_cwd = function(_) return vim.fn.getcwd() end,
                },
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
        sorts = {
            function(a, b)
                if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
                    return
                end
                return b.client_name == 'emmet_ls'
            end,
            -- default sorts
            'score',
            'sort_text',
        },
    },

    cmdline = {
        keymap = {
            ['<Tab>'] = { 'show', 'accept' },
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

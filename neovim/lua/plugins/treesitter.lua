require('nvim-treesitter.configs').setup({
    -- ensure_installed = "all",
    ensure_installed = {
        "awk",
        "bash",
        "c",
        "clojure",
        "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "dot",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "hcl",
        "html",
        "htmldjango",
        "http",
        "ini",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "ocaml",
        "perl",
        "pug",
        "python",
        "regex",
        "rst",
        "ruby",
        "rust",
        "sql",
        "svelte",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "zig",
        -- "jsx",
    },
    ignore_install = {}, -- List of parsers to ignore installing
    sync_install = false,
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "markdown" },
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and treesitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
        -- additional_vim_regex_highlighting = { "markdown" },
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
    context_commentstring = {
        enable = true
    },
    autotag = {
        enable = true,
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
        -- highlight_current_scope = { enable = true },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "<leader>gn",
            },
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["al"] = "@class.outer",
                ["il"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ax"] = "@block.outer",
                ["ix"] = "@block.inner",
                ["=l"] = "@assignment.lhs",
                ["=r"] = "@assignment.rhs",
                ["i="] = "@assignment.inner",
                ["a="] = "@assignment.outer",
                ["ic"] = "@call.inner",
                ["ac"] = "@call.outer",
                ["i/"] = "@comment.outer",
                ["a/"] = "@comment.outer",
            },
            selection_modes = {
                ['@function.outer'] = 'V',
                ['@function.inner'] = 'v',
                ['@class.outer'] = 'V',
                ['@class.inner'] = 'V',
                ['@block.outer'] = 'V',
                ['@block.inner'] = 'V',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]l"] = "@class.outer",
                ["]f"] = "@function.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[l"] = "@class.outer",
                ["[f"] = "@function.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["]A"] = "@parameter.inner",
            },
            swap_previous = {
                ["[A"] = "@parameter.inner",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'rounded',
            floating_preview_opts = {},
            peek_definition_code = {
                ['<leader>gp'] = '@function.outer',
            },
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
})

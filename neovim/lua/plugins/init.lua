local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- TOC:
-- 1_completion
-- 2_lsp_and_diagnostics
-- 3_treesitter
-- 4_telescope
-- 5_ui
-- 6_colors_and_highlighting
-- 7_file_management
-- 8_git
-- 9_markdown
-- 10_databases
-- 11_programming_misc
-- 12_text_manipulation
-- 13_navigation
-- 14_typescript
-- 15_formatting
-- 16_keybindings
-- 17_windows
-- 18_editing
-- 96_misc
-- 97_to_remove
-- 98_evaluating
-- 99_end

-- TODO: split the config:
-- https://lazy.folke.io/installation
-- https://lazy.folke.io/usage/structuring

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- top plugins
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "snacks.nvim",        words = { "Snacks" } },
                { path = "lazy.nvim",          words = { "LazyVim" } },
            },
        },
    },
    { -- optional `vim.uv` typings
        "Bilal2453/luvit-meta",
        lazy = true,
    },
    {
        -- TODO: setup debug: https://github.com/folke/snacks.nvim/blob/main/docs/debug.md
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                sections = {
                    { section = "header" },
                    { section = "startup", padding = 1 },
                },
            },
            indent = {
                enabled = true,
                animate = { enabled = false },
                scope = { enabled = true, },
                chunk = {
                    enabled = true,
                    char = {
                        corner_top = "╭",
                        corner_bottom = "╰",
                        horizontal = "─",
                        vertical = "│",
                        arrow = "─",
                    },
                },
            },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = false },
            words = {
                enabled = true,
                debounce = 200,
                notify_jump = false,
                notify_end = true,
            },
        },
    },

    --
    -- 1_completion
    --

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = require("plugins.cmp").dependencies,
        config = require("plugins.cmp").config,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        build = "make tiktoken",
        opts = {
            debug = true, -- Enable debugging
            -- See Configuration section for rest
            -- model = 'gpt-4o-mini',
            -- model = 'claude-3.5-sonnet',
            model = 'o1-mini',
            auto_insert_mode = true,
            window = {
                layout = 'float',
                relative = 'cursor',
                border = 'rounded',
                width = 0.6,
                height = 0.4,
                row = 1
            }
        },
        -- See Commands section for default commands if you want to lazy load on them
    },

    --
    -- 2_lsp_and_diagnostics
    --
    {
        "neovim/nvim-lspconfig",
        dependencies = { "folke/neodev.nvim" },
    },
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
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        },
        config = require("plugins.null-ls").config,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = {},
            automatic_installation = true,
        },
    },
    -- TODO: Review this
    -- { "RishabhRD/popfix" },
    { "RishabhRD/nvim-lsputils" },
    { "onsails/lspkind-nvim" },
    -- Incremental LSP rename command based on Neovim's command-preview feature
    {
        "smjonas/inc-rename.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        'arkav/lualine-lsp-progress',
        dependencies = { 'nvim-lualine/lualine.nvim' },
    },

    --
    -- 3_treesitter
    --

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        priority = 900,
        config = require("plugins.treesitter").config,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            separator = '─',
            -- mode = 'topline',
            mode = 'cursor',
            max_lines = 5,
            multiline_threshold = 5,
            min_window_height = 10,
        },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = true,
    },
    -- Use treesitter to auto close and auto rename html tags
    {
        "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                enable_close = false,
                enable_rename = true,
                enable_close_on_slash = true,
            }
        }
    },

    --
    -- 4_telescope
    --

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lazy = true,
        dependencies = require("plugins.telescope").dependencies,
        config = require("plugins.telescope").config,
    },

    --
    -- 5_ui
    --
    {
        "nvim-lualine/lualine.nvim",
        opts = require("plugins.lualine").opts,
    },
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = require("plugins.marks").opts,
    },
    -- hide gutter numbers for folds
    {
        -- TODO: consider replacing with Snacks.statuscolumn https://github.com/folke/snacks.nvim/blob/main/docs/statuscolumn.md
        "luukvbaal/statuscol.nvim",
        config = require("plugins.statuscol").config,
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            opts = { -- Default  Range
                -- stiffness = 0.8,   -- 0.6      [0, 1]
                -- trailing_stiffness = 0.5, -- 0.25     [0, 1]
                -- distance_stop_animating = 0.5, -- 0.1      > 0
                -- hide_target_hack = false, -- true     boolean
            },
        },
    },

    --
    -- 6_colors_and_highlighting
    --

    {
        'ribru17/bamboo.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('bamboo').setup {
                style = "multiplex",
                toggle_style_list = { "multiplex", "light" },
                -- toggle_style_key = "<Leader>xb", -- defined in lua/mapping/toggles.lua
                dim_inactive = true,
                diagnostics = {
                    darker = false,
                    undercurl = true,
                    background = true,
                },
                highlights = {
                    SnacksIndentScope = { fg = '#909090', fmt = 'nocombine' },
                    SnacksIndentChunk = { fg = '#909090', fmt = 'nocombine' },
                    ['@comment'] = { fg = '$grey' },
                },
            }
            require('bamboo').load()
        end,
    },

    -- disables search highlighting when you are done searching and re-enables it when you search again
    { "romainl/vim-cool" },

    -- highlighting visual selections
    { "Pocco81/HighStr.nvim" },
    --
    -- Highlight several words in different colors simultaneously
    {
        "inkarkat/vim-mark",
        keys = { "<Plug>MarkSet", "<Plug>MarkToggle", "<Plug>MarkClear" },
        dependencies = { "inkarkat/vim-ingo-library" },
        init = function()
            vim.g.mw_no_mappings = 1
            vim.g.mwDefaultHighlightingPalette = "extended"
        end,
    },

    {
        "tzachar/highlight-undo.nvim",
        config = true,
    },

    --
    -- 7_file_management
    --

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = require("plugins.neo-tree").dependencies,
        opts = require("plugins.neo-tree").opts,
    },

    {
        'echasnovski/mini.files',
        ---@diagnostic disable-next-line: assign-type-mismatch
        version = false,
        config = require("plugins.mini").files.config,
    },

    --
    -- 8_git
    --

    {
        "lewis6991/gitsigns.nvim",
        opts = require("plugins.gitsigns").opts,
    },

    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewFileHistory", "DiffviewClose", "DiffviewOpen" },
    },

    -- more pleasant editing on commit messages
    { "rhysd/committia.vim" },

    {
        'FabijanZulj/blame.nvim',
        cmd = 'ToggleBlame',
        opts = {
            virtual_style = 'right_alight',
            -- virtual_style = 'float',
            merge_consecutive = false,
        }
    },

    {
        'akinsho/git-conflict.nvim',
        -- lazy = true,
        -- cmd = {
        --     'GitConflictNextConflict',
        --     'GitConflictPrevConflict',
        --     'GitConlictListQf',
        -- },
        opts = {
            default_mappings = true,    -- disable buffer local mapping created by this plugin
            default_commands = true,    -- disable commands created by this plugin
            disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen',      -- command or function to open the conflicts list
            highlights = {              -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current = 'DiffText',
            }
        },
    },

    --
    -- 9_markdown
    --

    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        config = function()
            require('markview').setup({
                preview = {
                    hybrid_modes = { "n" },
                    ignore_previews = {
                        markdown = {
                            "!code_blocks",
                            -- "list_items",
                        },
                        markdown_inline = {
                            checkboxes = {
                            }
                        },
                    },
                    icon_provider = "devicons",
                },
                markdown_inline = {
                    -- checkboxes = {
                    --     enable = true,
                    --
                    --     -- 󰱒   󰄲 󰄵
                    --     checked = { text = "󰱒", hl = "MarkviewCheckboxChecked", scope_hl = "MarkviewCheckboxChecked" },
                    --     unchecked = { text = "󰄰", hl = "MarkviewCheckboxUnchecked", scope_hl = "MarkviewCheckboxUnchecked" },
                    --
                    --     ["/"] = { text = "󱎖", hl = "MarkviewCheckboxPending" },
                    --     [">"] = { text = "", hl = "MarkviewCheckboxCancelled" },
                    --     ["<"] = { text = "󰃖", hl = "MarkviewCheckboxCancelled" },
                    --     ["-"] = { text = "󰍶", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },
                    --
                    --     ["?"] = { text = "󰋗", hl = "MarkviewCheckboxPending" },
                    --     ["!"] = { text = "󰀦", hl = "MarkviewCheckboxUnchecked" },
                    --     ["*"] = { text = "󰓎", hl = "MarkviewCheckboxPending" },
                    --     ['"'] = { text = "󰸥", hl = "MarkviewCheckboxCancelled" },
                    --     ["l"] = { text = "󰆋", hl = "MarkviewCheckboxProgress" },
                    --     ["b"] = { text = "󰃀", hl = "MarkviewCheckboxProgress" },
                    --     ["i"] = { text = "󰰄", hl = "MarkviewCheckboxChecked" },
                    --     ["S"] = { text = "", hl = "MarkviewCheckboxChecked" },
                    --     ["I"] = { text = "󰛨", hl = "MarkviewCheckboxPending" },
                    --     ["p"] = { text = "", hl = "MarkviewCheckboxChecked" },
                    --     ["c"] = { text = "", hl = "MarkviewCheckboxUnchecked" },
                    --     ["f"] = { text = "󱠇", hl = "MarkviewCheckboxUnchecked" },
                    --     ["k"] = { text = "", hl = "MarkviewCheckboxPending" },
                    --     ["w"] = { text = "", hl = "MarkviewCheckboxProgress" },
                    --     ["u"] = { text = "󰔵", hl = "MarkviewCheckboxChecked" },
                    --     ["d"] = { text = "󰔳", hl = "MarkviewCheckboxUnchecked" },
                    -- },
                },
            })
            require("markview.extras.checkboxes").setup({
                states = {
                    { " ", "/", "x", "-" },
                },
            })
            require("markview.extras.headings").setup()
            -- require("markview.extras.editor").setup()
        end,
    },

    --
    -- 10_databases
    --

    --
    -- 11_programming_misc
    --
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {
            toggler = {
                line = "gcc",
                block = "gCC",
            },
            opleader = {
                line = "gc",
                block = "gC",
            },
        },
    },

    {
        'stevearc/aerial.nvim',
        opts = {
            layout = {
                max_width = 50,
                min_width = 20,
            },
            highlight_on_hober = true,
            show_guides = true,
        },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },

    {
        'Wansmer/treesj',
        keys = { 'K' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })
        end,
    },

    -- TODO: Remove?
    {
        "ThePrimeagen/refactoring.nvim",
        -- cmd = 'CodeActionMenu',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- "weilbith/nvim-code-action-menu",
        },
        config = true,
    },

    -- TODO: explore ibhagwan/fzf-lua as an alternative
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            require('actions-preview').setup({
                highlight_command = {
                    require("actions-preview.highlight").delta()
                },
                telescope = {
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.6,
                        height = 0.6,
                        preview_cutoff = 20,
                        -- preview_height = 0.7,
                        preview_height = function(_, _, max_lines)
                            return max_lines - 15
                        end,
                    },
                },
            })
        end
    },

    -- Highlight, list and search todo comments in your projects
    -- TODO: move to its own file
    {
        "folke/todo-comments.nvim",
        lazy = false,
        opts = require('plugins.todo-comments').opts,
    },

    --
    -- 12_text_manipulation
    --

    -- Set of operators and textobjects to search/select/edit sandwiched texts
    { "machakann/vim-sandwich" },
    {
        "godlygeek/tabular",
        cmd = "Tabularize",
    },

    --
    -- 13_navigation
    --

    {
        "kwkarlwang/bufjump.nvim",
        keys = { "<C-n>", "<C-p>" },
        opts = {
            forward_key = "<C-n>",
            backward_key = "<C-p>",
            on_success = nil,
        },
    },

    --
    -- 14_typescript
    --
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        -- configured in config/lsp.lua
    },
    -- Nvim lua plugin which adds support for twoslash queries into typescript projects
    {
        "marilari88/twoslash-queries.nvim",
        opts = {
            multi_line = false, -- to print types in multi line mode
            is_enabled = true,  -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
        },
    },
    {
        "davidosomething/format-ts-errors.nvim"
    },
    {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            keymaps = {
                toggle = '<leader>Te',
                go_to_definition = '<leader>Td',
            }
        }
    },

    --
    -- 15_formatting
    --
    {
        "elentok/format-on-save.nvim",
        config = require("plugins.format-on-save").config,
    },

    --
    -- 16_keybindings
    --
    {
        "folke/which-key.nvim",
        opts = require("plugins.which-key").opts,
    },

    --
    -- 17_windows
    --
    {
        "sindrets/winshift.nvim",
        lazy = true,
        cmd = "WinShift",
        opts = {
            highlight_moving_win = true,
            window_picker = function() return require('winpick').select() end,
        },
    },
    {
        "gbrlsnchs/winpick.nvim",
        lazy = true,
        opts = { border = "rounded" },
    },

    --
    -- 18_editing
    --

    -- TODO: use treesitter texobjects indent instead?
    { "michaeljsmith/vim-indent-object" },

    -- Additional text objects
    -- Provides:
    -- iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
    -- inX anX AnX InX for next object
    -- ilX alX AlX IlX for previous (last) object
    -- ia aa Ia Aa for arguments; works with nX/lX as well
    { "wellle/targets.vim" },

    --
    -- 96_misc
    --

    -- Readline style insertion
    {
        "tpope/vim-rsi",
        keys = { ":", "/", "?" },
    },

    -- handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
    { "kopischke/vim-fetch" },

    -- Heuristically set buffer options
    { "tpope/vim-sleuth" },

    -- ultra fold
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "LspAttach",
        opts = {}
    },

    {
        "jaimecgomezz/here.term",
        opts = {}
    },

    --
    -- 97_to_remove
    --

    --
    -- 98_evaluating
    --
    {
        'nullromo/go-up.nvim',
        config = true,
    },


    -- 99_end
}, {
    ui = {
        border = "rounded",
    },
    -- diff = 'browser',
    -- diff = 'git',
    -- diff = 'terminal_git',
    -- diff = 'diffview.nvim',
    checker = {
        enabled = false,
        frequency = 3600 * 48, -- every two days
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = true, -- get a notification when changes are found
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    }
})

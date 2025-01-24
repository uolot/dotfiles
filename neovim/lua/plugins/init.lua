local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- TOC:
-- 1_cmp
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
-- 98_misc
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
    -- 1_cmp
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
    { "RishabhRD/popfix" },
    { "RishabhRD/nvim-lsputils" },
    { "onsails/lspkind-nvim" },
    {
        "folke/trouble.nvim",
        -- lazy = true,
        cmd = 'Trouble',
        opts = {},
        -- opts = {
        --     icons = false,
        --     severity = vim.diagnostic.severity.INFO,
        -- },
    },
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
    -- Incremental LSP rename command based on Neovim's command-preview feature
    {
        "smjonas/inc-rename.nvim",
        event = "VeryLazy",
        config = true,
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
        "elentok/format-on-save.nvim",
        config = require("plugins.format-on-save").config,
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        -- configured in config/lsp.lua
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
    -- {
    --     'yorickpeterse/nvim-dd',
    --     opts = { timeout = 750 },
    -- },

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
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true,
                -- per_filetype = {
                --     ["html"] = {
                --         enable_close = false,
                --     },
                -- },
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
        'arkav/lualine-lsp-progress',
        dependencies = { 'nvim-lualine/lualine.nvim' },
    },
    {
        "folke/which-key.nvim",
        opts = require("plugins.which-key").opts,
    },
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = require("plugins.marks").opts,
    },
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
    -- hide gutter numbers for folds
    {
        -- TODO: consider replacing with Snacks.statuscolumn https://github.com/folke/snacks.nvim/blob/main/docs/statuscolumn.md
        "luukvbaal/statuscol.nvim",
        config = require("plugins.statuscol").config,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = require("plugins.indent-blankline").opts
    },
    {
        "gen740/SmoothCursor.nvim",
        enabled = false,
        opts = require("plugins.smooth-cursor").opts,
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
    {
        -- TODO: replace with Snacks.notifier? https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
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
                style = "vulgaris",
                toggle_style_list = { "vulgaris", "light" },
                -- toggle_style_key = "<Leader>xb", -- defined in lua/mapping/toggles.lua
                dim_inactive = true,
                diagnostics = {
                    darker = false,
                    undercurl = true,
                    background = true,
                },
                highlights = {
                    IblIndent = { fg = '#444444', fmt = 'nocombine' },
                    -- IblWhitespace = { bg = '#00ff00', fmt = 'nocombine' },
                    IblScope = { fg = '#909090', fmt = 'nocombine' },
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
    -- Highlight, list and search todo comments in your projects
    {
        "folke/todo-comments.nvim",
        lazy = false,
        opts = {
            signs = true,
            keywords = {
                FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "fixme" } },
                TODO = { icon = " ", color = "info", alt = { "it.todo", "test.todo" } },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = {} },
                NOTE = { icon = " ", color = "hint", alt = { "INFO", "it.skip", "test.skip" } },
                TEST = { icon = "⏲ ", color = "test", alt = {} },
            },
            merge_keywords = true,
            highlight = {
                multiline = false,
                comments_only = false,
                before = "fg",
                keyword = "bg",
                after = "fg",
                pattern = {
                    -- [[.*<(KEYWORDS)( |:|;|\s+|\.|,|;|$)]],
                    [[.*<(KEYWORDS)\s*]],
                    -- [[.*<(KEYWORDS)\s*(\(.*\))?\s*:?]],
                },
                exclude = {
                    "TelescopePrompt",
                    "TelescopeResults",
                    "help",
                    "lazy",
                    "lspinfo",
                    "mason",
                    "nvcheatsheet",
                    "nvdash",
                    "terminal",
                    'nerdtree',
                    'unite',
                    'OverseerForm',
                    'OverseerList',
                },
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },

        },
    },
    -- Easily add additional highlights to your buffers
    {
        "folke/paint.nvim",
        opts = require("plugins.paint").opts,
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

    -- { "tpope/vim-fugitive",      lazy = false },
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
        "preservim/vim-markdown",
        ft = { "markdown" },
        config = function()
            vim.g.vim_markdown_folding_disabled = 0
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_strikethrough = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_toml_frontmatter = 1
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
    -- 98_misc
    --

    -- TODO: use treesitter texobjects indent instead?
    { "michaeljsmith/vim-indent-object" },
    -- Readline style insertion
    {
        "tpope/vim-rsi",
        keys = { ":", "/", "?" },
    },
    -- handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
    { "kopischke/vim-fetch" },

    -- Additional text objects
    -- Provides:
    -- iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
    -- inX anX AnX InX for next object
    -- ilX alX AlX IlX for previous (last) object
    -- ia aa Ia Aa for arguments; works with nX/lX as well
    { "wellle/targets.vim" },
    -- Heuristically set buffer options
    { "tpope/vim-sleuth" },
    -- ultra fold
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "LspAttach",
        opts = {}
    },
    -- {
    --     'nvim-zh/colorful-winsep.nvim',
    --     config = true,
    --     event = { "WinNew" },
    -- },
    -- Embed Neovim in Chrome, Firefox & others.
    {
        "glacambre/firenvim",
        -- cond = not not vim.g.started_by_firenvim,
        lazy = not vim.g.started_by_firenvim,
        build = require("plugins.firenvim").build,
        config = require("plugins.firenvim").config,
    },
    {
        "carbon-steel/detour.nvim",
        cmd = 'Detour',
        -- config = true,
    },

    {
        "jaimecgomezz/here.term",
        opts = {}
    },

    {
        'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })
        end,
    },

    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>yf",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>yy",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                '<leader>yt',
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = 'g?',
            },
        },
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

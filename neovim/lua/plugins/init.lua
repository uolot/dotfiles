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
-- 98_nursery
-- 99_end

-- TODO: split the config:
-- https://lazy.folke.io/installation
-- https://lazy.folke.io/usage/structuring

vim.loader.enable()

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
        opts = require("plugins.snacks").opts,
    },

    --
    -- 1_completion
    --

    -- TODO: remove
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = { "InsertEnter", "CmdLineEnter" },
    --     dependencies = require("plugins.cmp").dependencies,
    --     config = require("plugins.cmp").config,
    -- },
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        version = '*',
        dependencies = require('plugins.blink').dependencies,
        opts = require('plugins.blink').opts,
        opts_extend = { "sources.default" }
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken",
        opts = {
            debug = true, -- Enable debugging
            -- See Configuration section for rest
            -- model = 'gpt-4o-mini',
            model = 'claude-3.7-sonnet',
            -- model = 'o1-mini',
            auto_insert_mode = true,
            window = {
                layout = 'float',
                relative = 'cursor',
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
        event = "FileType",
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = require("config.lsp").dependencies,
        config = require("config.lsp").config,
    },
    -- TODO: remove?
    -- {
    --     "jay-babu/mason-null-ls.nvim",
    --     opts = {
    --         ensure_installed = {},
    --         automatic_installation = true,
    --     },
    -- },

    -- Incremental LSP rename command based on Neovim's command-preview feature
    {
        "smjonas/inc-rename.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        'arkav/lualine-lsp-progress',
        lazy = true,
        dependencies = { 'nvim-lualine/lualine.nvim' },
    },

    --
    -- 3_treesitter
    --

    {
        "nvim-treesitter/nvim-treesitter",
        event = { 'BufReadPre', 'BufNewFile' },
        build = ":TSUpdate",
        priority = 900,
        config = require("plugins.treesitter").config,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = 'VeryLazy',
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = 'VeryLazy',
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
        event = "VeryLazy",
        config = true,
    },
    -- Use treesitter to auto close and auto rename html tags
    {
        "windwp/nvim-ts-autotag",
        event = 'VeryLazy',
        opts = {
            opts = {
                enable_close = false,
                enable_rename = true,
                enable_close_on_slash = true,
            }
        }
    },
    {
        'Wansmer/treesj',
        lazy = true,
        keys = {
            { "K", function() require('treesj').toggle() end, mode = { "n", "x" }, desc = "Split/join" },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        opts = {
            use_default_keymaps = false,
            max_join_length = 600,
            on_error = function() vim.lsp.buf.hover() end,
        },
    },

    --
    -- 4_telescope
    --

    {
        "nvim-telescope/telescope.nvim",
        event = 'VeryLazy',
        enabled = false,
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
        event = "VeryLazy",
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
            stiffness = 0.5,
            trailing_stiffness = 0.49,
            never_draw_over_target = false,
        },
    },
    {
        'stevearc/quicker.nvim',
        event = "FileType qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
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
                    LspReferenceText = { bg = '#505050', fmt = 'bold' },
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

    {
        "tzachar/highlight-undo.nvim",
        config = true,
    },

    --
    -- 7_file_management
    --

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
        --     'GitConflictListQf',
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
        event = "LspAttach",
        opts = {
            layout = {
                max_width = 50,
                min_width = 20,
                placement = 'edge',
            },
            attach_mode = 'global',
            -- close_automatic_events = { 'unfocus' },
            close_on_select = true,
            -- autojump = true,
            highlight_on_hover = true,
            show_guides = true,
        },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },

    -- TODO: explore ibhagwan/fzf-lua as an alternative
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            require('actions-preview').setup({
                backend = { "snacks" },
                highlight_command = {
                    require("actions-preview.highlight").delta()
                },
                snacks = {
                    -- layout = { preset = "default" },
                    -- layout = { preset = "vscode" },
                    -- layout = { preset = "vertical" },
                    -- layout = { preset = "ivy", layout = { position = "top" } },
                    -- layout = { preset = "ivy", layout = { position = "bottom" } },
                    layout = { preset = "dropdown" },
                    -- layout = { preset = "select" },
                    -- layout = { preset = "sidebar", layout = { position = "right" } },
                    -- layout = { preset = "sidebar", layout = { position = "left" } },
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
        enabled = false,
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        -- configured in config/lsp.lua
    },
    -- Nvim lua plugin which adds support for twoslash queries into typescript projects
    {
        "marilari88/twoslash-queries.nvim",
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
        opts = {
            multi_line = false, -- to print types in multi line mode
            is_enabled = true,  -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
        },
    },
    {
        "davidosomething/format-ts-errors.nvim",
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
    },
    {
        "OlegGulevskyy/better-ts-errors.nvim",
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            keymaps = {
                toggle = '<leader>gE',
                -- go_to_definition = '<leader>Td',
            }
        }
    },
    {
        'dmmulroy/ts-error-translator.nvim',
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
    },

    {
        'yioneko/nvim-vtsls',
        ft = { "typescript", "typescriptreact", "typescript.tsx" },
    },

    --
    -- 15_formatting
    --
    {
        'stevearc/conform.nvim',
        opts = require('plugins.conform').opts,
        init = require('plugins.conform').init,
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
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "kevinhwang91/promise-async" },
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
    -- 98_nursery
    --
    {
        'Chaitanyabsprip/fastaction.nvim',
        opts = require('plugins.fastaction').opts,
    },

    {
        "briangwaltney/paren-hint.nvim",
        lazy = false,
        config = true,
    },

    {
        "leath-dub/snipe.nvim",
        opts = {
            ui = {
                position = "center",
                open_win_override = {
                    border = "rounded",
                },
            },
        }
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

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
-- 99_misc

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
vim.opt.rtp:prepend(lazypath)

-- TODO: replace with `config = true`?
local function setup(plugin)
    return function()
        require(plugin).setup()
    end
end

require("lazy").setup({
    -- top plugins
    { "lewis6991/impatient.nvim" },
    { "folke/neodev.nvim",       opts = {}, ft = 'lua', priority = 1000 },

    --
    -- 1_cmp
    --

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = require("plugins.cmp").dependencies,
        config = require("plugins.cmp").config,
    },

    --
    -- 2_lsp_and_diagnostics
    --

    { "neovim/nvim-lspconfig",             dependencies = { "folke/neodev.nvim" } },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            pip = { upgrade_pip = true },
            ui = { border = "rounded" },
        },
    },
    { "williamboman/mason-lspconfig.nvim", opts = {} },
    { "VonHeikemen/lsp-zero.nvim",         branch = "v2.x" },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
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
    { "RishabhRD/popfix" },
    { "RishabhRD/nvim-lsputils" },
    { "onsails/lspkind-nvim" },
    {
        "folke/trouble.nvim",
        lazy = true,
        opts = {
            icons = false,
            severity = vim.diagnostic.severity.INFO,
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        cmd = 'CodeActionsMenu',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "weilbith/nvim-code-action-menu",
        },
        config = setup('refactoring'),
    },
    -- Pop-up menu for code actions to show meta-information and diff preview - provides ":CodeActionMenu"
    -- TODO: archived: https://github.com/weilbith/nvim-code-action-menu/commit/8c7672a#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5
    --       remove if actions-preview works well
    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
    },
    {
        "aznhe21/actions-preview.nvim",
    },
    -- Incremental LSP rename command based on Neovim's command-preview feature
    {
        "smjonas/inc-rename.nvim",
        config = setup("inc_rename"),
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
    { "elentok/format-on-save.nvim", config = require("plugins.format-on-save").config },
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
    {
        'yorickpeterse/nvim-dd',
        opts = { timeout = 750 },
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
        "nvim-treesitter/nvim-treesitter-refactor",
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
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    --
    -- 4_telescope
    --

    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            menu = {
                width = 100,
            },
        },
    },
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
    { "nvim-lualine/lualine.nvim",   opts = require("plugins.lualine").opts },
    {
        'arkav/lualine-lsp-progress',
        dependencies = { 'nvim-lualine/lualine.nvim' },
    },
    { "folke/which-key.nvim", opts = require("plugins.which-key").opts },
    { "chentoast/marks.nvim", opts = require("plugins.marks").opts },
    {
        "sindrets/winshift.nvim",
        lazy = true,
        cmd = "WinShift",
        opts = { highlight_moving_win = true },
    },
    {
        "gbrlsnchs/winpick.nvim",
        lazy = true,
        opts = { border = "rounded" },
    },
    -- hide gutter numbers for folds
    { "luukvbaal/statuscol.nvim", config = require("plugins.statuscol").config },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = require("plugins.indent-blankline").opts
    },
    {
        "gen740/SmoothCursor.nvim",
        opts = require("plugins.smooth-cursor").opts,
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
                dim_inactive = false,
                diagnostics = {
                    darker = true,
                    undercurl = true,
                },
                highlights = {
                    IblIndent = { fg = '#444444', fmt = 'nocombine' },
                    -- IblWhitespace = { bg = '#00ff00', fmt = 'nocombine' },
                    IblScope = { fg = '#909090', fmt = 'nocombine' },
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
            signs = false,
            highlight = {
                multiline = false,
                -- pattern = [[.*<(KEYWORDS)\s*:]],
                pattern = [[.*<(KEYWORDS)\s*]],
                comments_only = true,
            },
            search = {
                pattern = [[\b(KEYWORDS)\b]],
            },
        },
    },
    -- Easily add additional highlights to your buffers
    { "folke/paint.nvim",        opts = require("plugins.paint").opts },
    {
        "tzachar/highlight-undo.nvim",
        keys = { "u", "U", "<C-r>" },
        opts = {},
    },

    --
    -- 7_file_management
    --

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = require("plugins.neo-tree").dependencies,
    },
    {
        'echasnovski/mini.files',
        ---@diagnostic disable-next-line: assign-type-mismatch
        version = false,
        opts = {
            windows = {
                preview = true,
                width_preview = 50,
            },
        },
    },

    --
    -- 8_git
    --

    -- { "tpope/vim-fugitive",      lazy = false },
    { "lewis6991/gitsigns.nvim", opts = require("plugins.gitsigns").opts },
    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    { "sindrets/diffview.nvim",  cmd = { "DiffviewFileHistory", "DiffviewClose", "DiffviewOpen" } },
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
        "almo7aya/openingh.nvim",
        cmd = { 'OpenInGHRepo', 'OpenInGHFile', 'OpenInGHFileLines' },
        config = true,
    },

    --
    -- 9_markdown
    --
    {
        "iamcco/markdown-preview.nvim",
        ft = 'markdown',
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.g.mkdp_auto_close = 0
        end,
    },
    {
        "zk-org/zk-nvim",
        cmd = { 'ZkBacklinks', 'ZkInsertLink', 'ZkLinks', 'ZkNew', 'ZkNewFromContentSelection',
            'ZkNewFromTitleSelection', 'ZkNotes', 'ZkTags' },
        dependencies = 'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').load_extension('zk')
            require("zk").setup({ picker = "telescope" })
        end,
    },
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
    -- Additional highlights for markdown
    -- {
    --     "lukas-reineke/headlines.nvim",
    --     lazy = true,
    --     ft = { "markdown" },
    --     config = require("plugins.headlines").config,
    -- },

    --
    -- 10_databases
    --
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            -- Enable nvim-cmp autocomplete
            vim.cmd(
                [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
            )
        end,
    },

    --
    -- 99_misc
    --

    -- TODO: use treesitter texobjects indent instead?
    { "michaeljsmith/vim-indent-object" },
    -- Readline style insertion
    { "tpope/vim-rsi",                  keys = { ":", "/", "?" } },
    -- handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
    { "kopischke/vim-fetch" },
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
    -- Run Async Shell Commands
    { "skywind3000/asyncrun.vim", cmd = "AsyncRun" },

    -- Set of operators and textobjects to search/select/edit sandwiched texts
    { "machakann/vim-sandwich" },
    -- Additional text objects
    -- Provides:
    -- iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
    -- inX anX AnX InX for next object
    -- ilX alX AlX IlX for previous (last) object
    -- ia aa Ia Aa for arguments; works with nX/lX as well
    { "wellle/targets.vim" },
    {
        "godlygeek/tabular",
        cmd = "Tabularize",
    },
    -- Heuristically set buffer options
    { "tpope/vim-sleuth" },
    -- ultra fold
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "LspAttach",
        opts = {}
    },
    -- Inversed J
    {
        "AckslD/nvim-trevJ.lua",
        -- keys = { 'K' },
        config = function()
            local trevj = require("trevj")
            trevj.setup()
            require("which-key").register({ K = { trevj.format_at_cursor, "Split" } })
        end,
    },
    {
        "kiran94/s3edit.nvim",
        cmd = "S3Edit",
        opts = {
            -- exclude = { ".git", ".hoodie", ".parquet", ".zip" },
            autocommand_events = { "BufWritePost" },
        },
    },
    -- Broken, revisit when updated
    -- { 'nvim-zh/colorful-winsep.nvim', config = true, event = { "WinNew" } },
    -- Embed Neovim in Chrome, Firefox & others.
    {
        "glacambre/firenvim",
        -- cond = not not vim.g.started_by_firenvim,
        lazy = not vim.g.started_by_firenvim,
        build = require("plugins.firenvim").build,
        config = require("plugins.firenvim").config,
    },
    -- { 'stevearc/overseer.nvim' },
    {
        "kwkarlwang/bufjump.nvim",
        keys = { "<C-n>", "<C-p>" },
        opts = {
            forward = "<C-n>",
            backward = "<C-p>",
            on_success = nil,
        },
    },
    {
        'abecodes/tabout.nvim',
        opts = {
            ignore_beginning = false,
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = '`', close = '`' },
                { open = '(', close = ')' },
                { open = '[', close = ']' },
                { open = '{', close = '}' },
                { open = '<', close = '>' },
            },
        },
        dependencies = { 'hrsh7th/nvim-cmp', 'nvim-treesitter' },
    },
    {
        "carbon-steel/detour.nvim",
        cmd = 'Detour',
        -- config = true,
    },
}, {
    ui = {
        border = "rounded",
    },
    -- diff = 'browser',
    -- diff = 'git',
    -- diff = 'diffview.nvim',
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

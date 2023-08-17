local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require('lazy').setup({

    -- cache plugins
    { 'lewis6991/impatient.nvim',  url = 'https://github.com/lewis6991/impatient.nvim' },

    -- dependencies
    { 'nvim-lua/plenary.nvim' },
    { 'kevinhwang91/promise-async' },

    --
    -- cmp
    --

    {
        'hrsh7th/nvim-cmp',
        url = 'https://github.com/hrsh7th/nvim-cmp',
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            -- sources
            { 'hrsh7th/cmp-buffer',                   url = 'https://github.com/hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-calc',                     url = 'https://github.com/hrsh7th/cmp-calc' },
            { 'hrsh7th/cmp-cmdline',                  url = 'https://github.com/hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-emoji',                    url = 'https://github.com/hrsh7th/cmp-emoji' },
            { 'hrsh7th/cmp-nvim-lsp',                 url = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol', url = 'https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help',  url = 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-path',                     url = 'https://github.com/hrsh7th/cmp-path' },
            { 'ray-x/cmp-treesitter',                 url = 'https://github.com/ray-x/cmp-treesitter' },

            -- comparators
            { 'lukas-reineke/cmp-under-comparator',   url = 'https://github.com/lukas-reineke/cmp-under-comparator' },

            -- snippet plugin is required by nvim-cmp
            { 'hrsh7th/vim-vsnip',                    url = 'https://github.com/hrsh7th/vim-vsnip' },
            { 'hrsh7th/vim-vsnip-integ',              url = 'https://github.com/hrsh7th/vim-vsnip-integ' },
            { 'hrsh7th/cmp-vsnip',                    url = 'https://github.com/hrsh7th/cmp-vsnip' },

            -- copilot
            {
                'zbirenbaum/copilot-cmp',
                url = 'https://github.com/zbirenbaum/copilot-cmp',
                dependencies = { { 'zbirenbaum/copilot.lua', url = 'https://github.com/zbirenbaum/copilot.lua' } }
            },
        },
        config = function()
            require("plugins.cmp")
        end
    },

    --
    -- lsp
    --

    -- Plug 'williamboman/nvim-lsp-installer'
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim',          build = ':MasonUpdate' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v2.x' },
    {
        'jose-elias-alvarez/null-ls.nvim',
        url = 'https://github.com/jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('plugins.null-ls')
        end
    },
    { 'jay-babu/mason-null-ls.nvim' },
    { 'RishabhRD/popfix',           url = 'https://github.com/RishabhRD/popfix' },
    { 'RishabhRD/nvim-lsputils',    url = 'https://github.com/RishabhRD/nvim-lsputils' },
    { 'onsails/lspkind-nvim',       url = 'https://github.com/onsails/lspkind-nvim' },
    -- { 'kosayoda/nvim-lightbulb',          url = 'https://github.com/kosayoda/nvim-lightbulb' },
    {
        'folke/trouble.nvim',
        lazy = true,
        opts = {
            icons = false,
            severity = vim.diagnostic.severity.INFO,
        }
    },

    -- Pop-up menu for code actions to show meta-information and diff preview
    --     Provides ":CodeActionMenu"
    {
        'weilbith/nvim-code-action-menu',
        url = 'https://github.com/weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu'
    },

    -- Incremental LSP rename command based on Neovim's command-preview feature
    { 'smjonas/inc-rename.nvim',                  url = 'https://github.com/smjonas/inc-rename.nvim' },

    -- Nvim lua plugin which adds support for twoslash queries into typescript projects
    {
        'marilari88/twoslash-queries.nvim',
        url = 'https://github.com/marilari88/twoslash-queries.nvim',
        opts = {
            multi_line = false, -- to print types in multi line mode
            is_enabled = true,  -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
        }
    },

    --
    -- treesitter --
    --

    {
        'nvim-treesitter/nvim-treesitter',
        url = 'https://github.com/nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        priority = 900,
        config = function()
            require('plugins.treesitter')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        url = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
    },
    { 'nvim-treesitter/nvim-treesitter-refactor', url = 'https://github.com/nvim-treesitter/nvim-treesitter-refactor' },
    { 'nvim-treesitter/nvim-treesitter-context',  url = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        url = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
    },
    -- Use treesitter to auto close and auto rename html tags
    { 'windwp/nvim-ts-autotag', url = 'https://github.com/windwp/nvim-ts-autotag' },


    --
    -- telescope
    --

    {
        'nvim-telescope/telescope.nvim',
        url = 'https://github.com/nvim-telescope/telescope.nvim',
        branch = '0.1.x'
    },
    { 'kelly-lin/telescope-ag', url = 'https://github.com/kelly-lin/telescope-ag' },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        url = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    { 'nvim-telescope/telescope-ui-select.nvim', url = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
    {
        'nvim-telescope/telescope-live-grep-args.nvim',
        url = 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim',
        lazy = true,
        config = function()
            require("telescope").load_extension("live_grep_args")
        end,
    },


    --
    -- colorschemes
    --

    { 'nvim-lualine/lualine.nvim',               url = 'https://github.com/nvim-lualine/lualine.nvim' },

    {
        'rebelot/kanagawa.nvim',
        url = 'https://github.com/rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd('colorscheme kanagawa')
        end,
        opts = {
            theme = 'dragon',
            background = {
                dark = 'dragon',
                light = 'lotus',
            },
            dimInactive = false,
            keywordStyle = { italic = false, bold = false },
            statementStyle = { italic = false, bold = true },
        },
    },

    --
    -- file explorer
    --

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                version = "1.*",
                config = function()
                    require 'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        }
    },


    --
    -- git
    --

    { 'tpope/vim-fugitive',              url = 'https://github.com/tpope/vim-fugitive',              lazy = false },
    { 'lewis6991/gitsigns.nvim',         url = 'https://github.com/lewis6991/gitsigns.nvim' },

    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    { 'sindrets/diffview.nvim',          url = 'https://github.com/sindrets/diffview.nvim' },

    -- more pleasant editing on commit messages
    { 'rhysd/committia.vim',             url = 'https://github.com/rhysd/committia.vim' },

    -- A git commit browser in Vim
    -- { 'junegunn/gv.vim',                 url = 'https://github.com/junegunn/gv.vim' },

    -- GitHub extension for fugitive.vim
    { 'tpope/vim-rhubarb',               url = 'https://github.com/tpope/vim-rhubarb' },

    -- One second to read GitHub code with vim
    -- { 'drzel/vim-repo-edit',             url = 'https://github.com/drzel/vim-repo-edit' },


    --
    -- vimwiki & markdown
    --

    { 'vimwiki/vimwiki',                 url = 'https://github.com/vimwiki/vimwiki',                 lazy = true },
    { 'ElPiloto/telescope-vimwiki.nvim', url = 'https://github.com/ElPiloto/telescope-vimwiki.nvim', lazy = true },

    -- Markdown live preview
    {
        'iamcco/markdown-preview.nvim',
        url = 'https://github.com/iamcco/markdown-preview.nvim',
        ft = { 'markdown', 'vim-plug' },
        config = function()
            vim.fn['mkdp#util#install']()
            vim.g.mkdp_auto_close = 0
        end
    },

    -- Neovim extension for zk
    {
        'mickael-menu/zk-nvim',
        url = 'https://github.com/mickael-menu/zk-nvim',
        config = function()
            require('zk').setup({ picker = 'telescope' })
        end
    },
    {
        'preservim/vim-markdown',
        url = 'https://github.com/preservim/vim-markdown',
        config = function()
            vim.g.vim_markdown_folding_disabled = 0
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_strikethrough = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_toml_frontmatter = 1
            vim.g.vim_markdown_edit_url_in = 'vsplit'
        end
    },

    -- Additional highlights for markdown
    {
        'lukas-reineke/headlines.nvim',
        url = 'https://github.com/lukas-reineke/headlines.nvim',
        lazy = true,
        ft = { 'markdown' },
        -- dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('headlines').setup({
                markdown = {
                    -- query = vim.treesitter.parse_query(
                    query = vim.treesitter.query.parse(
                        "markdown",
                        [[
                            (atx_heading [
                                (atx_h1_marker)
                                (atx_h2_marker)
                                (atx_h3_marker)
                                (atx_h4_marker)
                                (atx_h5_marker)
                                (atx_h6_marker)
                            ] @headline)

                            (thematic_break) @dash

                            (fenced_code_block) @codeblock

                            (block_quote_marker) @quote
                            (block_quote (paragraph (inline (block_continuation) @quote)))
                        ]]
                    ),
                    headline_highlights = {
                        "Headline1",
                        "Headline2",
                        "Headline3",
                        "Headline4",
                        "Headline5",
                    },
                    codeblock_highlight = "",
                    dash_highlight = "Dash",
                    dash_string = "─",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = false,
                    -- fat_headline_upper_string = "▄",
                    -- fat_headline_lower_string = "▀",
                },
            })
        end
    },


    --
    -- misc
    --

    -- Vim plugin that defines a new text object representing lines of code at the
    -- same indent level. Useful for python/vim scripts, etc.
    { 'michaeljsmith/vim-indent-object', url = 'https://github.com/michaeljsmith/vim-indent-object' },
    -- { 'karb94/neoscroll.nvim',           url = 'https://github.com/karb94/neoscroll.nvim' },

    -- Readline style insertion
    { 'tpope/vim-rsi',                   url = 'https://github.com/tpope/vim-rsi' },

    -- disables search highlighting when you are done searching and re-enables it when you search again
    { 'romainl/vim-cool',                url = 'https://github.com/romainl/vim-cool' },

    -- handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
    { 'kopischke/vim-fetch',             url = 'https://github.com/kopischke/vim-fetch' },

    {
        'numToStr/Comment.nvim',
        url = 'https://github.com/numToStr/Comment.nvim',
        opts = {
            toggler = {
                line = 'gcc',
                block = 'gCC',
            },
            opleader = {
                line = 'gc',
                block = 'gC',
            },
        }
    },

    -- highlighting visual selections
    { 'Pocco81/HighStr.nvim', url = 'https://github.com/Pocco81/HighStr.nvim' },

    -- Highlight several words in different colors simultaneously
    {
        'inkarkat/vim-mark',
        url = 'https://github.com/inkarkat/vim-mark',
        dependencies = { 'inkarkat/vim-ingo-library' },
        init = function()
            vim.g.mw_no_mappings = 1
            vim.g.mwDefaultHighlightingPalette = 'extended'
        end
    },

    -- displays a popup with possible keybindings of the command you started typing
    { 'folke/which-key.nvim', url = 'https://github.com/folke/which-key.nvim' },

    -- Highlight, list and search todo comments in your projects
    {
        'folke/todo-comments.nvim',
        url = 'https://github.com/folke/todo-comments.nvim',
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
        }
    },

    -- A better user experience for interacting with and manipulating Vim marks
    -- mx              Set mark x
    -- m,              Set the next available alphabetical (lowercase) mark
    -- m;              Toggle the next available mark at the current line
    -- dmx             Delete mark x
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
    -- m:              Preview mark. This will prompt you for a specific mark to
    --                 preview; press <cr> to preview the next mark.
    -- m[0-9]          Add a bookmark from bookmark group[0-9].
    -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- m}              Move to the next bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- m{              Move to the previous bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- dm=             Delete the bookmark under the cursor.
    { 'chentoast/marks.nvim',     url = 'https://github.com/chentoast/marks.nvim' },

    -- Run Async Shell Commands
    { 'skywind3000/asyncrun.vim', url = 'https://github.com/skywind3000/asyncrun.vim' },

    -- Set of operators and textobjects to search/select/edit sandwiched texts
    { 'machakann/vim-sandwich',   url = 'https://github.com/machakann/vim-sandwich' },

    -- Additional text objects
    -- Provides:
    -- iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
    -- inX anX AnX InX for next object
    -- ilX alX AlX IlX for previous (last) object
    -- ia aa Ia Aa for arguments; works with nX/lX as well
    { 'wellle/targets.vim',       url = 'https://github.com/wellle/targets.vim' },

    {
        'godlygeek/tabular',
        url = 'https://github.com/godlygeek/tabular',
        cmd = 'Tabularize'
    },

    -- Heuristically set buffer options
    { 'tpope/vim-sleuth', url = 'https://github.com/tpope/vim-sleuth' },
    { 'jbyuki/venn.nvim', url = 'https://github.com/jbyuki/venn.nvim' },
    {
        'levouh/tint.nvim',
        url = 'https://github.com/levouh/tint.nvim',
        config = function()
            require("tint").setup({
                tint = 15,
                tint_background_colors = true,
            })
        end
    },
    { 'sindrets/winshift.nvim',              url = 'https://github.com/sindrets/winshift.nvim',             lazy = true },
    { 'gbrlsnchs/winpick.nvim',              url = 'https://github.com/gbrlsnchs/winpick.nvim',             lazy = true },

    -- hide gutter numbers for folds
    { 'luukvbaal/statuscol.nvim',            url = 'https://github.com/luukvbaal/statuscol.nvim' },
    -- ultra fold
    { 'kevinhwang91/nvim-ufo',               url = 'https://github.com/kevinhwang91/nvim-ufo',              opts = {} },
    { 'lukas-reineke/indent-blankline.nvim', url = 'https://github.com/lukas-reineke/indent-blankline.nvim' },

    -- Inversed J
    {
        'AckslD/nvim-trevJ.lua',
        url = 'https://github.com/AckslD/nvim-trevJ.lua/',
        config = function()
            require('trevj').setup()
        end
    },
    {
        'kiran94/s3edit.nvim',
        url = 'https://github.com/kiran94/s3edit.nvim',
        cmd = 'S3Edit',
        opts = {
            -- exclude = { ".git", ".hoodie", ".parquet", ".zip" },
            autocommand_events = { "BufWritePost" },
        }
    },

    -- Broken, revisit when updated
    -- { 'nvim-zh/colorful-winsep.nvim',     url = 'https://github.com/nvim-zh/colorful-winsep.nvim' },
    { 'tweekmonster/startuptime.vim', url = 'https://github.com/tweekmonster/startuptime.vim' },

    -- Easily add additional highlights to your buffers
    { 'folke/paint.nvim',             url = 'https://github.com/folke/paint.nvim' },

    -- Neovim file explorer: edit your filesystem like a buffer
    {
        'stevearc/oil.nvim',
        url = 'https://github.com/stevearc/oil.nvim',
        lazy = false,
        config = function()
            require('oil').setup()
        end
    },

    -- Embed Neovim in Chrome, Firefox & others.
    {
        'glacambre/firenvim',
        url = 'https://github.com/glacambre/firenvim',
        cond = not not vim.g.started_by_firenvim,
        build = function()
            require('lazy').load({ plugins = 'firenvim', wait = true })
            vim.fn['firenvim#install'](0)
        end,
        config = function()
            vim.g.firenvim_config = {
                globalSettings = {
                    alt = 'all',
                },
                localSettings = {
                    ['.*'] = {
                        cmdline = 'neovim',
                        content = 'text',
                        priority = 0,
                        selector = 'textarea',
                        takeover = 'never',
                    },
                },
            }

            vim.opt.background = 'light'
            vim.opt.guifont = 'BlexMono Ner Font Mono:h12'
        end
    },

    {
        'gen740/SmoothCursor.nvim',
        url = 'https://github.com/gen740/SmoothCursor.nvim',
        opts = {
            autostart = true,
            cursor = "", -- cursor shape (need nerd font)
            texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
            linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
            type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
            fancy = {
                enable = true, -- enable fancy mode
                head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
                -- head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
                body = {
                    { cursor = "●", texthl = "SmoothCursorRed" },
                    { cursor = "●", texthl = "SmoothCursorOrange" },
                    { cursor = "●", texthl = "SmoothCursorYellow" },
                    { cursor = "•", texthl = "SmoothCursorGreen" },
                    { cursor = "•", texthl = "SmoothCursorAqua" },
                    { cursor = ".", texthl = "SmoothCursorBlue" },
                    { cursor = ".", texthl = "SmoothCursorPurple" },
                },
                tail = { cursor = nil, texthl = "SmoothCursor" }
            },
            flyin_effect = nil,        --bottom" or "top"
            speed = 25,                -- max is 100 to stick to your current position
            intervals = 35,            -- tick interval
            priority = 10,             -- set marker priority
            timeout = 2000,            -- timout for animation
            threshold = 3,             -- animate if threshold lines jump
            disable_float_win = false, -- disable on float window
            enabled_filetypes = nil,   -- example: { "lua", "vim" }
            disabled_filetypes = nil,  -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
        }
    },
    -- { 'stevearc/overseer.nvim',           url = 'https://github.com/stevearc/overseer.nvim' },
    { 'rcarriga/nvim-notify', url = 'https://github.com/rcarriga/nvim-notify' },
    {
        'kwkarlwang/bufjump.nvim',
        url = 'https://github.com/kwkarlwang/bufjump.nvim',
        opts = {
            forward = '<C-n>',
            backward = '<C-p>',
            on_success = nil
        }
    },
    {
        'tzachar/highlight-undo.nvim',
        url = 'https://github.com/tzachar/highlight-undo.nvim',
        keys = { 'u', 'U', '<C-r>' },
        opts = {}
    },
    { 'folke/neodev.nvim',    url = 'https://github.com/folke/neodev.nvim',   priority = 1000 },
    {
        'marcushwz/nvim-workbench',
        url = 'https://github.com/weizheheng/nvim-workbench',
        keys = {
            '<Plug>ToggleProjectWorkbench',
            '<Plug>ToggleBranchWorkbench',
            '<Plug>WorkbenchToggleCheckbox',
        },
        init = function()
            vim.g.workbench_border = 'rounded'
        end
    },

}, {
    -- diff = 'browser',
    -- diff = 'git',
    -- diff = 'diffview.nvim',
})
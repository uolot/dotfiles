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
    { 'lewis6991/impatient.nvim',             url = 'https://github.com/lewis6991/impatient.nvim' },

    -- dependencies
    { 'nvim-lua/plenary.nvim' },
    { 'kevinhwang91/promise-async' },

    -- Completion --

    -- Extra completions
    -- TODO: check https://github.com/xero/dotfiles/blob/main/neovim/.config/nvim/lua/plugins/cmp.lua
    { 'hrsh7th/cmp-buffer',                   url = 'https://github.com/hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-calc',                     url = 'https://github.com/hrsh7th/cmp-calc' },
    { 'hrsh7th/cmp-cmdline',                  url = 'https://github.com/hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-emoji',                    url = 'https://github.com/hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-nvim-lsp',                 url = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol', url = 'https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help',  url = 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-path',                     url = 'https://github.com/hrsh7th/cmp-path' },

    -- A snippet plugin is required by nvim-cmp
    { 'hrsh7th/vim-vsnip',                    url = 'https://github.com/hrsh7th/vim-vsnip' },
    { 'hrsh7th/vim-vsnip-integ',              url = 'https://github.com/hrsh7th/vim-vsnip-integ' },
    { 'hrsh7th/cmp-vsnip',                    url = 'https://github.com/hrsh7th/cmp-vsnip' },

    -- Completion plugin
    { 'hrsh7th/nvim-cmp',                     url = 'https://github.com/hrsh7th/nvim-cmp' },

    --
    -- lsp --
    --

    -- Plug 'williamboman/nvim-lsp-installer'
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim',              build = ':MasonUpdate' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',            branch = 'v2.x' },
    { 'jose-elias-alvarez/null-ls.nvim',      url = 'https://github.com/jose-elias-alvarez/null-ls.nvim' },
    { 'jay-babu/mason-null-ls.nvim' },
    { 'RishabhRD/popfix',                     url = 'https://github.com/RishabhRD/popfix' },
    { 'RishabhRD/nvim-lsputils',              url = 'https://github.com/RishabhRD/nvim-lsputils' },
    { 'onsails/lspkind-nvim',                 url = 'https://github.com/onsails/lspkind-nvim' },
    -- { 'kosayoda/nvim-lightbulb',          url = 'https://github.com/kosayoda/nvim-lightbulb' },
    -- {
    --     'lukas-reineke/lsp-format.nvim',
    --     url = 'https://github.com/lukas-reineke/lsp-format.nvim',
    --     config = function()
    --         require("lsp-format").setup({})
    --     end
    -- },
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

    -- LSP signature hint as you type
    -- { 'ray-x/lsp_signature.nvim',         url = 'https://github.com/ray-x/lsp_signature.nvim' },

    -- Incremental LSP rename command based on Neovim's command-preview feature
    { 'smjonas/inc-rename.nvim',                  url = 'https://github.com/smjonas/inc-rename.nvim' },

    -- render diagnostics using virtual lines on top of the real line of code.
    -- { 'Maan2003/lsp_lines.nvim',         url = 'https://github.com/Maan2003/lsp_lines.nvim' },
    -- { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },

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
            local configs = require('nvim-treesitter.configs')

            configs.setup({
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
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
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
                -- rainbow = {
                --     enable = true,
                --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
                --     -- colors = {}, -- table of hex strings
                --     -- termcolors = {} -- table of colour name strings
                -- },
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
                            -- ["]c"] = "@class.outer",
                            -- ["]m"] = "@function.outer",
                            ["]]"] = { "@class.outer", "@function.outer" },
                            ["]m"] = { "@class.outer", "@function.outer" },
                            -- ["]b"] = "@block.outer",
                        },
                        goto_previous_start = {
                            -- ["[c"] = "@class.outer",
                            -- ["[m"] = "@function.outer",
                            ["[["] = { "@class.outer", "@function.outer" },
                            ["[m"] = { "@class.outer", "@function.outer" },
                            -- ["[b"] = "@block.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["]a"] = { "@parameter.inner" },
                        },
                        swap_previous = {
                            ["[a"] = { "@parameter.inner" },
                        },
                    },
                },
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = '<CR>',
                        -- scope_incremental = '<CR>',
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
    -- Rainbow parentheses for neovim using treesitter
    -- TODO: no longer maintained, migrate to nvim-ts-rainbow2
    -- Plug 'p00f/nvim-ts-rainbow'


    -- Telescope --

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


    -- Colorschemes --

    { 'nvim-lualine/lualine.nvim',               url = 'https://github.com/nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-web-devicons',             url = 'https://github.com/nvim-tree/nvim-web-devicons' },

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

    -- Misc --

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

    -- " auto-generate ctags file
    -- { 'ludovicchabant/vim-gutentags',    url = 'https://github.com/ludovicchabant/vim-gutentags' },
    --     let g:gutentags_project_root = [
    --             \'.python-version',
    --             \'docker-compose.yml',
    --             \'Makefile',
    --             \'package.json',
    --             \'pyproject.toml',
    --             \'README',
    --             \'README.md'
    --             \'requirements.txt',
    --             \'setup.py',
    --             \]


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
    -- {
    --     'hynek/vim-python-pep8-indent',
    --     url = 'https://github.com/hynek/vim-python-pep8-indent',
    --     ft =
    --     'python'
    -- },

    -- highlighting visual selections
    { 'Pocco81/HighStr.nvim',     url = 'https://github.com/Pocco81/HighStr.nvim' },
    -- Highlight several words in different colors simultaneously
    -- { 'inkarkat/vim-ingo-library', url = 'https://github.com/inkarkat/vim-ingo-library' },
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
    { 'folke/which-key.nvim',     url = 'https://github.com/folke/which-key.nvim' },

    -- A file explorer tree for neovim written in lua
    { 'kyazdani42/nvim-tree.lua', url = 'https://github.com/kyazdani42/nvim-tree.lua' },


    -- Git --

    { 'tpope/vim-fugitive',       url = 'https://github.com/tpope/vim-fugitive',      lazy = false },
    { 'lewis6991/gitsigns.nvim',  url = 'https://github.com/lewis6991/gitsigns.nvim' },

    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    { 'sindrets/diffview.nvim',   url = 'https://github.com/sindrets/diffview.nvim' },

    -- more pleasant editing on commit messages
    { 'rhysd/committia.vim',      url = 'https://github.com/rhysd/committia.vim' },

    -- A git commit browser in Vim
    -- { 'junegunn/gv.vim',                 url = 'https://github.com/junegunn/gv.vim' },

    -- GitHub extension for fugitive.vim
    { 'tpope/vim-rhubarb',        url = 'https://github.com/tpope/vim-rhubarb' },
    -- extension to fugitive.vim for gitlab support
    -- { 'shumphrey/fugitive-gitlab.vim',   url = 'https://github.com/shumphrey/fugitive-gitlab.vim' },
    -- Add Bitbucket URL support to fugitive.vim's :Gbrowse command
    -- { 'tommcdo/vim-fubitive',            url = 'https://github.com/tommcdo/vim-fubitive' },

    -- One second to read GitHub code with vim
    -- { 'drzel/vim-repo-edit',             url = 'https://github.com/drzel/vim-repo-edit' },


    -- Misc -

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
    { 'chentoast/marks.nvim',            url = 'https://github.com/chentoast/marks.nvim' },

    -- Vimwiki & Markdown --

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
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_strikethrough = 1
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

    -- Misc --

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

    -- Nvim lua plugin which adds support for twoslash queries into typescript projects
    {
        'marilari88/twoslash-queries.nvim',
        url = 'https://github.com/marilari88/twoslash-queries.nvim',
        opts = {
            multi_line = false, -- to print types in multi line mode
            is_enabled = true,  -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
        }
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
    { 'rcarriga/nvim-notify',   url = 'https://github.com/rcarriga/nvim-notify' },
    {
        'kwkarlwang/bufjump.nvim',
        url = 'https://github.com/kwkarlwang/bufjump.nvim',
        opts = {
            forward = '<C-n>',
            backward = '<C-p>',
            on_success = nil
        }
    },
    -- { 'github/copilot.vim',               url = 'https://github.com/github/copilot.vim' },
    { 'zbirenbaum/copilot.lua', url = 'https://github.com/zbirenbaum/copilot.lua' },
    { 'zbirenbaum/copilot-cmp', url = 'https://github.com/zbirenbaum/copilot-cmp' },
    {
        'tzachar/highlight-undo.nvim',
        url = 'https://github.com/tzachar/highlight-undo.nvim',
        keys = { 'u', 'U', '<C-r>' },
        opts = {}
    },
    { 'folke/neodev.nvim', url = 'https://github.com/folke/neodev.nvim', priority = 1000 },
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

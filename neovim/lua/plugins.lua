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

    -- " cache plugins
    { 'lewis6991/impatient.nvim',             url = 'https://github.com/lewis6991/impatient.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'kevinhwang91/promise-async' },

    -- " -- Completion --

    -- " Extra completions
    { 'hrsh7th/cmp-buffer',                   url = 'https://github.com/hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-calc',                     url = 'https://github.com/hrsh7th/cmp-calc' },
    { 'hrsh7th/cmp-cmdline',                  url = 'https://github.com/hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-emoji',                    url = 'https://github.com/hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-nvim-lsp',                 url = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol', url = 'https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help',  url = 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-path',                     url = 'https://github.com/hrsh7th/cmp-path' },

    -- " A snippet plugin is required by nvim-cmp
    { 'hrsh7th/vim-vsnip',                    url = 'https://github.com/hrsh7th/vim-vsnip' },
    { 'hrsh7th/vim-vsnip-integ',              url = 'https://github.com/hrsh7th/vim-vsnip-integ' },
    { 'hrsh7th/cmp-vsnip',                    url = 'https://github.com/hrsh7th/cmp-vsnip' },

    -- " Completion plugin
    { 'hrsh7th/nvim-cmp',                     url = 'https://github.com/hrsh7th/nvim-cmp' },

    -- " -- LSP --

    -- " Plug 'williamboman/nvim-lsp-installer'
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

    { 'folke/trouble.nvim' },

    -- " Pop-up menu for code actions to show meta-information and diff preview
    -- "     Provides ":CodeActionMenu"
    { 'weilbith/nvim-code-action-menu',       url = 'https://github.com/weilbith/nvim-code-action-menu' },

    -- " LSP signature hint as you type
    -- { 'ray-x/lsp_signature.nvim',         url = 'https://github.com/ray-x/lsp_signature.nvim' },

    -- " Incremental LSP rename command based on Neovim's command-preview feature
    { 'smjonas/inc-rename.nvim',              url = 'https://github.com/smjonas/inc-rename.nvim' },

    -- " render diagnostics using virtual lines on top of the real line of code.
    -- { 'Maan2003/lsp_lines.nvim',         url = 'https://github.com/Maan2003/lsp_lines.nvim' },
    -- { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },

    -- " -- Treesitter --

    {
        'nvim-treesitter/nvim-treesitter',
        url = 'https://github.com/nvim-treesitter/nvim-treesitter',
        build =
        ':TSUpdate'
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        url =
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
    },
    { 'nvim-treesitter/nvim-treesitter-refactor', url = 'https://github.com/nvim-treesitter/nvim-treesitter-refactor' },
    { 'nvim-treesitter/nvim-treesitter-context',  url = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        url =
        'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
    },
    -- " Use treesitter to auto close and auto rename html tags
    { 'windwp/nvim-ts-autotag', url = 'https://github.com/windwp/nvim-ts-autotag' },
    -- " Rainbow parentheses for neovim using treesitter
    -- " TODO: no longer maintained, migrate to nvim-ts-rainbow2
    -- " Plug 'p00f/nvim-ts-rainbow'


    -- " -- Telescope --

    {
        'nvim-telescope/telescope.nvim',
        url = 'https://github.com/nvim-telescope/telescope.nvim',
        branch =
        '0.1.x'
    },
    { 'kelly-lin/telescope-ag', url = 'https://github.com/kelly-lin/telescope-ag' },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        url = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        build =
        'make'
    },
    { 'nvim-telescope/telescope-ui-select.nvim', url = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },


    -- " -- Colorschemes --

    { 'nvim-lualine/lualine.nvim',               url = 'https://github.com/nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-web-devicons',             url = 'https://github.com/nvim-tree/nvim-web-devicons' },

    -- " grep: github-colors github-theme
    {
        'projekt0n/github-nvim-theme',
        url = 'https://github.com/projekt0n/github-nvim-theme',
        branch =
        '0.0.x'
    },

    { 'rebelot/kanagawa.nvim',           url = 'https://github.com/rebelot/kanagawa.nvim' },

    -- " -- Misc --

    -- " Vim plugin that defines a new text object representing lines of code at the
    -- " same indent level. Useful for python/vim scripts, etc.
    { 'michaeljsmith/vim-indent-object', url = 'https://github.com/michaeljsmith/vim-indent-object' },
    -- { 'karb94/neoscroll.nvim',           url = 'https://github.com/karb94/neoscroll.nvim' },

    -- " Readline style insertion
    { 'tpope/vim-rsi',                   url = 'https://github.com/tpope/vim-rsi' },

    -- " disables search highlighting when you are done searching and re-enables it when you search again
    { 'romainl/vim-cool',                url = 'https://github.com/romainl/vim-cool' },

    -- " handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
    { 'kopischke/vim-fetch',             url = 'https://github.com/kopischke/vim-fetch' },

    -- " " auto-generate ctags file
    -- { 'ludovicchabant/vim-gutentags',    url = 'https://github.com/ludovicchabant/vim-gutentags' },
    -- "     let g:gutentags_project_root = [
    -- "             \'.python-version',
    -- "             \'docker-compose.yml',
    -- "             \'Makefile',
    -- "             \'package.json',
    -- "             \'pyproject.toml',
    -- "             \'README',
    -- "             \'README.md'
    -- "             \'requirements.txt',
    -- "             \'setup.py',
    -- "             \]


    { 'numToStr/Comment.nvim',           url = 'https://github.com/numToStr/Comment.nvim' },
    -- {
    --     'hynek/vim-python-pep8-indent',
    --     url = 'https://github.com/hynek/vim-python-pep8-indent',
    --     ft =
    --     'python'
    -- },

    -- " highlighting visual selections
    { 'Pocco81/HighStr.nvim',            url = 'https://github.com/Pocco81/HighStr.nvim' },
    -- " Highlight several words in different colors simultaneously
    -- let g:mw_no_mappings = 1
    { 'inkarkat/vim-ingo-library',       url = 'https://github.com/inkarkat/vim-ingo-library' },
    { 'inkarkat/vim-mark',               url = 'https://github.com/inkarkat/vim-mark' },


    -- " displays a popup with possible keybindings of the command you started typing
    { 'folke/which-key.nvim',            url = 'https://github.com/folke/which-key.nvim' },

    -- " A file explorer tree for neovim written in lua
    { 'kyazdani42/nvim-tree.lua',        url = 'https://github.com/kyazdani42/nvim-tree.lua' },


    -- " -- Git --

    { 'tpope/vim-fugitive',              url = 'https://github.com/tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim',         url = 'https://github.com/lewis6991/gitsigns.nvim' },

    -- " Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    { 'sindrets/diffview.nvim',          url = 'https://github.com/sindrets/diffview.nvim' },

    -- " more pleasant editing on commit messages
    { 'rhysd/committia.vim',             url = 'https://github.com/rhysd/committia.vim' },

    -- " A git commit browser in Vim
    -- { 'junegunn/gv.vim',                 url = 'https://github.com/junegunn/gv.vim' },

    -- " GitHub extension for fugitive.vim
    { 'tpope/vim-rhubarb',               url = 'https://github.com/tpope/vim-rhubarb' },
    -- " extension to fugitive.vim for gitlab support
    -- { 'shumphrey/fugitive-gitlab.vim',   url = 'https://github.com/shumphrey/fugitive-gitlab.vim' },
    -- " Add Bitbucket URL support to fugitive.vim's :Gbrowse command
    -- { 'tommcdo/vim-fubitive',            url = 'https://github.com/tommcdo/vim-fubitive' },

    -- " One second to read GitHub code with vim
    -- { 'drzel/vim-repo-edit',             url = 'https://github.com/drzel/vim-repo-edit' },


    -- " -- Misc -

    -- " Highlight, list and search todo comments in your projects
    { 'folke/todo-comments.nvim',        url = 'https://github.com/folke/todo-comments.nvim' },

    -- " A better user experience for interacting with and manipulating Vim marks
    -- " mx              Set mark x
    -- " m,              Set the next available alphabetical (lowercase) mark
    -- " m;              Toggle the next available mark at the current line
    -- " dmx             Delete mark x
    -- " dm-             Delete all marks on the current line
    -- " dm<space>       Delete all marks in the current buffer
    -- " m]              Move to next mark
    -- " m[              Move to previous mark
    -- " m:              Preview mark. This will prompt you for a specific mark to
    -- "                 preview; press <cr> to preview the next mark.
    -- " m[0-9]          Add a bookmark from bookmark group[0-9].
    -- " dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- " m}              Move to the next bookmark having the same type as the bookmark under
    -- "                 the cursor. Works across buffers.
    -- " m{              Move to the previous bookmark having the same type as the bookmark under
    -- "                 the cursor. Works across buffers.
    -- " dm=             Delete the bookmark under the cursor.
    { 'chentoast/marks.nvim',            url = 'https://github.com/chentoast/marks.nvim' },

    -- " -- Vimwiki & Markdown --

    { 'vimwiki/vimwiki',                 url = 'https://github.com/vimwiki/vimwiki' },
    { 'ElPiloto/telescope-vimwiki.nvim', url = 'https://github.com/ElPiloto/telescope-vimwiki.nvim' },

    -- " Markdown live preview
    -- FIXME: figure how to run 'do' command with lazy
    -- { 'iamcco/markdown-preview.nvim', url = 'https://github.com/iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} },
    -- let g:mkdp_auto_close = 0

    -- " Neovim extension for zk
    { 'mickael-menu/zk-nvim',            url = 'https://github.com/mickael-menu/zk-nvim' },
    { 'preservim/vim-markdown',          url = 'https://github.com/preservim/vim-markdown' },
    -- let g:vim_markdown_folding_disabled = 1
    -- let g:vim_markdown_no_default_key_mappings = 1
    -- let g:vim_markdown_toc_autofit = 1
    -- let g:vim_markdown_conceal_code_blocks = 0
    -- let g:vim_markdown_strikethrough = 1

    -- " Additional highlights for markdown
    { 'lukas-reineke/headlines.nvim',    url = 'https://github.com/lukas-reineke/headlines.nvim' },

    -- " -- Misc --

    -- " Run Async Shell Commands
    { 'skywind3000/asyncrun.vim',        url = 'https://github.com/skywind3000/asyncrun.vim' },

    -- " Set of operators and textobjects to search/select/edit sandwiched texts
    { 'machakann/vim-sandwich',          url = 'https://github.com/machakann/vim-sandwich' },

    -- " Additional text objects
    -- " Provides:
    -- " iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
    -- " inX anX AnX InX for next object
    -- " ilX alX AlX IlX for previous (last) object
    -- " ia aa Ia Aa for arguments; works with nX/lX as well
    { 'wellle/targets.vim',              url = 'https://github.com/wellle/targets.vim' },

    -- " https://github.com/godlygeek/tabular
    {
        'godlygeek/tabular',
        url = 'https://github.com/godlygeek/tabular',
        cmd =
        'Tabularize'
    },

    -- " Heuristically set buffer options
    { 'tpope/vim-sleuth',                    url = 'https://github.com/tpope/vim-sleuth' },
    { 'jbyuki/venn.nvim',                    url = 'https://github.com/jbyuki/venn.nvim' },
    { 'levouh/tint.nvim',                    url = 'https://github.com/levouh/tint.nvim' },
    { 'sindrets/winshift.nvim',              url = 'https://github.com/sindrets/winshift.nvim' },
    { 'gbrlsnchs/winpick.nvim',              url = 'https://github.com/gbrlsnchs/winpick.nvim' },

    -- " hide gutter numbers for folds
    { 'luukvbaal/statuscol.nvim',            url = 'https://github.com/luukvbaal/statuscol.nvim' },
    -- " ultra fold
    { 'kevinhwang91/nvim-ufo',               url = 'https://github.com/kevinhwang91/nvim-ufo' },
    { 'lukas-reineke/indent-blankline.nvim', url = 'https://github.com/lukas-reineke/indent-blankline.nvim' },

    -- " Inversed J
    { 'AckslD/nvim-trevJ.lua/',              url = 'https://github.com/AckslD/nvim-trevJ.lua/' },
    {
        'kiran94/s3edit.nvim',
        url = 'https://github.com/kiran94/s3edit.nvim',
        cmd =
        'S3Edit'
    },

    -- " Broken, revisit when updated
    -- { 'nvim-zh/colorful-winsep.nvim',     url = 'https://github.com/nvim-zh/colorful-winsep.nvim' },
    { 'tweekmonster/startuptime.vim',     url = 'https://github.com/tweekmonster/startuptime.vim' },

    -- " Easily add additional highlights to your buffers
    { 'folke/paint.nvim',                 url = 'https://github.com/folke/paint.nvim' },

    -- " Neovim file explorer: edit your filesystem like a buffer
    { 'stevearc/oil.nvim',                url = 'https://github.com/stevearc/oil.nvim' },

    -- " Embed Neovim in Chrome, Firefox & others.
    -- FIXME
    -- { 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }, url = 'https://github.com/glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } },

    -- " Nvim lua plugin which adds support for twoslash queries into typescript projects
    { 'marilari88/twoslash-queries.nvim', url = 'https://github.com/marilari88/twoslash-queries.nvim' },
    { 'gen740/SmoothCursor.nvim',         url = 'https://github.com/gen740/SmoothCursor.nvim' },
    { 'stevearc/overseer.nvim',           url = 'https://github.com/stevearc/overseer.nvim' },
    { 'rcarriga/nvim-notify',             url = 'https://github.com/rcarriga/nvim-notify' },
    { 'kwkarlwang/bufjump.nvim',          url = 'https://github.com/kwkarlwang/bufjump.nvim' },
    -- { 'github/copilot.vim',               url = 'https://github.com/github/copilot.vim' },
    { 'zbirenbaum/copilot.lua',           url = 'https://github.com/zbirenbaum/copilot.lua' },
    { 'zbirenbaum/copilot-cmp',           url = 'https://github.com/zbirenbaum/copilot-cmp' },
    { 'tzachar/highlight-undo.nvim',      url = 'https://github.com/tzachar/highlight-undo.nvim' },
    { 'VidocqH/lsp-lens.nvim',            url = 'https://github.com/VidocqH/lsp-lens.nvim' },
    { 'folke/neodev.nvim',                url = 'https://github.com/folke/neodev.nvim' },

})

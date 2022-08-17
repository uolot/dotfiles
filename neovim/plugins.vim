" install plug.vim
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-lua/plenary.nvim'

" -- LSP --

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

" https://github.com/RishabhRD/popfix
Plug 'RishabhRD/popfix'
" https://github.com/RishabhRD/nvim-lsputils
Plug 'RishabhRD/nvim-lsputils'

" https://github.com/onsails/lspkind-nvim
Plug 'onsails/lspkind-nvim'

" https://github.com/kosayoda/nvim-lightbulb
Plug 'kosayoda/nvim-lightbulb'

" Creates missing LSP diagnostics highlight groups
" https://github.com/folke/lsp-colors.nvim
Plug 'folke/lsp-colors.nvim'

Plug 'folke/trouble.nvim'

" Pop-up menu for code actions to show meta-information and diff preview
"     Provides ":CodeActionMenu"
" https://github.com/weilbith/nvim-code-action-menu
Plug 'weilbith/nvim-code-action-menu'

" LSP signature hint as you type
" https://github.com/ray-x/lsp_signature.nvim
Plug 'ray-x/lsp_signature.nvim'

" https://github.com/jose-elias-alvarez/null-ls.nvim
Plug 'jose-elias-alvarez/null-ls.nvim'

" Incremental LSP rename command based on Neovim's command-preview feature
" https://github.com/smjonas/inc-rename.nvim
Plug 'smjonas/inc-rename.nvim'

" -- Completion --

Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'hrsh7th/cmp-buffer'
" https://github.com/hrsh7th/cmp-path
Plug 'hrsh7th/cmp-path'
" https://github.com/hrsh7th/cmp-cmdline
Plug 'hrsh7th/cmp-cmdline'
" https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
" https://github.com/hrsh7th/cmp-calc
Plug 'hrsh7th/cmp-calc'
" https://github.com/uga-rosa/cmp-dictionary
" Plug 'uga-rosa/cmp-dictionary'
" https://github.com/hrsh7th/cmp-omni
Plug 'hrsh7th/cmp-omni'
" https://github.com/quangnguyen30192/cmp-nvim-tags
" Plug 'quangnguyen30192/cmp-nvim-tags'
" https://github.com/hrsh7th/cmp-emoji
Plug 'hrsh7th/cmp-emoji'

" A snippet plugin is required by nvim-cmp
" https://github.com/hrsh7th/vim-vsnip
Plug 'hrsh7th/vim-vsnip'
" https://github.com/hrsh7th/vim-vsnip-integ
Plug 'hrsh7th/vim-vsnip-integ'
" https://github.com/hrsh7th/cmp-vsnip
Plug 'hrsh7th/cmp-vsnip'

Plug 'hrsh7th/nvim-cmp'

" -- Treesitter --

Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Use treesitter to auto close and auto rename html tags
" https://github.com/windwp/nvim-ts-autotag
Plug 'windwp/nvim-ts-autotag'

" Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Rainbow parentheses for neovim using treesitter
" https://sr.ht/~p00f/nvim-ts-rainbow/
Plug 'p00f/nvim-ts-rainbow'


" -- Telescope --

Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" https://github.com/xiyaowong/telescope-emoji.nvim
Plug 'xiyaowong/telescope-emoji.nvim'


" -- Colorschemes --

" https://github.com/nvim-lualine/lualine.nvim
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" grep: github-colors github-theme
" https://github.com/projekt0n/github-nvim-theme
Plug 'projekt0n/github-nvim-theme'

" -- Misc --

" Vim plugin that defines a new text object representing lines of code at the
" same indent level. Useful for python/vim scripts, etc.
" https://github.com/michaeljsmith/vim-indent-object
Plug 'michaeljsmith/vim-indent-object'

Plug 'lewis6991/gitsigns.nvim'

Plug 'karb94/neoscroll.nvim'

" Readline style insertion
Plug 'tpope/vim-rsi'

" disables search highlighting when you are done searching and re-enables it when you search again
Plug 'romainl/vim-cool'

" handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
Plug 'kopischke/vim-fetch'

" auto-generate ctags file
Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_project_root = [
            \'package.json',
            \'docker-compose.yml',
            \'Makefile',
            \'pyproject.toml',
            \'.python-version',
            \'README',
            \'README.md'
            \'requirements.txt',
            \'setup.py',
            \]

" https://github.com/numToStr/Comment.nvim
Plug 'numToStr/Comment.nvim'

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

" highlighting visual selections
" https://github.com/Pocco81/HighStr.nvim
Plug 'Pocco81/HighStr.nvim'

" Highlight several words in different colors simultaneously
" https://github.com/inkarkat/vim-mark
let g:mw_no_mappings = 1
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'


" Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is
" https://github.com/DanilaMihailov/beacon.nvim
Plug 'danilamihailov/beacon.nvim'
    let g:beacon_shrink = 0
    let g:beacon_timeout = 200

" " https://github.com/blueyed/vim-diminactive
" Plug 'blueyed/vim-diminactive'
"     let g:diminactive_use_colorcolumn = 1
"     let g:diminactive_use_syntax = 0

" https://github.com/sunjon/Shade.nvim
Plug 'sunjon/Shade.nvim'

" displays a popup with possible keybindings of the command you started typing
" https://github.com/folke/which-key.nvim
Plug 'folke/which-key.nvim'

" A file explorer tree for neovim written in lua
" https://github.com/kyazdani42/nvim-tree.lua
Plug 'kyazdani42/nvim-tree.lua'


" -- Git --

Plug 'tpope/vim-fugitive'

" more pleasant editing on commit messages
" https://github.com/rhysd/committia.vim
Plug 'rhysd/committia.vim'

" https://github.com/junegunn/gv.vim
" A git commit browser in Vim
Plug 'junegunn/gv.vim'

" GitHub extension for fugitive.vim
" https://github.com/tpope/vim-rhubarb
Plug 'tpope/vim-rhubarb'

" extension to fugitive.vim for gitlab support
" https://github.com/shumphrey/fugitive-gitlab.vim
Plug 'shumphrey/fugitive-gitlab.vim'

" Add Bitbucket URL support to fugitive.vim's :Gbrowse command
" https://github.com/tommcdo/vim-fubitive
Plug 'tommcdo/vim-fubitive'

" One second to read GitHub code with vim
" https://github.com/drzel/vim-repo-edit
Plug 'drzel/vim-repo-edit'


" -- Misc -

" Highlight, list and search todo comments in your projects
" https://github.com/folke/todo-comments.nvim
Plug 'folke/todo-comments.nvim'

" Peek lines just when you intend
" https://github.com/nacro90/numb.nvim
Plug 'nacro90/numb.nvim'

" A better user experience for interacting with and manipulating Vim marks
" https://github.com/chentau/marks.nvim
" mx              Set mark x
" m,              Set the next available alphabetical (lowercase) mark
" m;              Toggle the next available mark at the current line
" dmx             Delete mark x
" dm-             Delete all marks on the current line
" dm<space>       Delete all marks in the current buffer
" m]              Move to next mark
" m[              Move to previous mark
" m:              Preview mark. This will prompt you for a specific mark to
"                 preview; press <cr> to preview the next mark.
" m[0-9]          Add a bookmark from bookmark group[0-9].
" dm[0-9]         Delete all bookmarks from bookmark group[0-9].
" m}              Move to the next bookmark having the same type as the bookmark under
"                 the cursor. Works across buffers.
" m{              Move to the previous bookmark having the same type as the bookmark under
"                 the cursor. Works across buffers.
" dm=             Delete the bookmark under the cursor.
Plug 'chentoast/marks.nvim'

" -- Vimwiki --

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
" https://github.com/ElPiloto/telescope-vimwiki.nvim
Plug 'ElPiloto/telescope-vimwiki.nvim'

" Markdown live preview
" https://github.com/iamcco/markdown-preview.nvim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    let g:mkdp_auto_close = 0

" " https://github.com/github/copilot.vim
" Plug 'github/copilot.vim'
"     imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
"     let g:copilot_no_tab_map = v:true
"     let g:copilot_filetypes = {
"         \ 'TelescopePrompt': v:false
"         \ }

" Add extra window movements with <C-w> g [hjkl]
" https://github.com/andymass/vim-tradewinds
Plug 'andymass/vim-tradewinds'

" Neovim extension for zk
" https://github.com/mickael-menu/zk-nvim
Plug 'mickael-menu/zk-nvim'

" Run Async Shell Commands
" https://github.com/skywind3000/asyncrun.vim
Plug 'skywind3000/asyncrun.vim'
" https://github.com/skywind3000/asynctasks.vim
" Plug 'skywind3000/asynctasks.vim'

" Set of operators and textobjects to search/select/edit sandwiched texts
" https://github.com/machakann/vim-sandwich
Plug 'machakann/vim-sandwich'

" Additional text objects
" Provides:
" iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
" inX anX AnX InX for next object
" ilX alX AlX IlX for previous (last) object
" ia aa Ia Aa for arguments; works with nX/lX as well
" " https://github.com/wellle/targets.vim
Plug 'wellle/targets.vim'

" Standalone UI for nvim-lsp progress
" https://github.com/j-hui/fidget.nvim
Plug 'j-hui/fidget.nvim'

" https://github.com/nvim-telescope/telescope-fzf-native.nvim
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" https://github.com/godlygeek/tabular
Plug 'godlygeek/tabular'

" https://github.com/preservim/vim-markdown
Plug 'preservim/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_toc_autofit = 1
    let g:vim_markdown_conceal_code_blocks = 0
    let g:vim_markdown_strikethrough = 1


" Heuristically set buffer options
" https://github.com/tpope/vim-sleuth
Plug 'tpope/vim-sleuth'

" Incremental fuzzy search motion plugin for Neovim
" https://github.com/rlane/pounce.nvim
Plug 'rlane/pounce.nvim'

" Fix CursorHold Performance (recommended for nvim-lightbulb)
" https://github.com/antoinemadec/FixCursorHold.nvim
Plug 'antoinemadec/FixCursorHold.nvim'
    let g:cursorhold_updatetime = 100

" Single tabpage interface for easily cycling through diffs for all modified files for any git rev
" https://github.com/sindrets/diffview.nvim
Plug 'sindrets/diffview.nvim'

call plug#end()

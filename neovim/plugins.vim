" install plug.vim
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')

" cache plugins
Plug 'https://github.com/lewis6991/impatient.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'kevinhwang91/promise-async'

" -- LSP --

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

Plug 'https://github.com/RishabhRD/popfix'
Plug 'https://github.com/RishabhRD/nvim-lsputils'

Plug 'https://github.com/onsails/lspkind-nvim'

Plug 'https://github.com/kosayoda/nvim-lightbulb'

" Creates missing LSP diagnostics highlight groups
" TODO: is this still needed in neovim 0.8?
" Plug 'https://github.com/folke/lsp-colors.nvim'

Plug 'folke/trouble.nvim'

" Pop-up menu for code actions to show meta-information and diff preview
"     Provides ":CodeActionMenu"
Plug 'https://github.com/weilbith/nvim-code-action-menu'

" LSP signature hint as you type
" Plug 'https://github.com/ray-x/lsp_signature.nvim'

Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim'

" Incremental LSP rename command based on Neovim's command-preview feature
Plug 'https://github.com/smjonas/inc-rename.nvim'

" render diagnostics using virtual lines on top of the real line of code.
" Plug 'https://github.com/Maan2003/lsp_lines.nvim'

" -- Completion --

" Extra completions
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/hrsh7th/cmp-buffer'
Plug 'https://github.com/hrsh7th/cmp-path'
Plug 'https://github.com/hrsh7th/cmp-cmdline'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'https://github.com/hrsh7th/cmp-calc'
Plug 'https://github.com/hrsh7th/cmp-omni'
Plug 'https://github.com/hrsh7th/cmp-emoji'
" Plug 'https://github.com/tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help'

" A snippet plugin is required by nvim-cmp
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/hrsh7th/vim-vsnip-integ'
Plug 'https://github.com/hrsh7th/cmp-vsnip'

" Completion plugin
Plug 'https://github.com/hrsh7th/nvim-cmp'

" Plug 'https://github.com/codota/tabnine-nvim', { 'do': './dl_binaries.sh' }

" -- Treesitter --

Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter-refactor'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter-context'
Plug 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
" Use treesitter to auto close and auto rename html tags
Plug 'https://github.com/windwp/nvim-ts-autotag'
" Rainbow parentheses for neovim using treesitter
" TODO: no longer maintained, find a replacement
" Plug 'p00f/nvim-ts-rainbow'


" -- Telescope --

Plug 'https://github.com/nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'https://github.com/kelly-lin/telescope-ag'
Plug 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'https://github.com/nvim-telescope/telescope-ui-select.nvim'


" -- Colorschemes --

Plug 'https://github.com/nvim-lualine/lualine.nvim'
" Plug 'https://github.com/kyazdani42/nvim-web-devicons'
Plug 'https://github.com/nvim-tree/nvim-web-devicons'

" grep: github-colors github-theme
Plug 'https://github.com/projekt0n/github-nvim-theme'

" -- Misc --

" Vim plugin that defines a new text object representing lines of code at the
" same indent level. Useful for python/vim scripts, etc.
Plug 'https://github.com/michaeljsmith/vim-indent-object'

" Plug 'https://github.com/karb94/neoscroll.nvim'

" Readline style insertion
Plug 'https://github.com/tpope/vim-rsi'

" disables search highlighting when you are done searching and re-enables it when you search again
Plug 'https://github.com/romainl/vim-cool'

" handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
Plug 'https://github.com/kopischke/vim-fetch'

" " auto-generate ctags file
" Plug 'https://github.com/ludovicchabant/vim-gutentags'
"     let g:gutentags_project_root = [
"             \'.python-version',
"             \'docker-compose.yml',
"             \'Makefile',
"             \'package.json',
"             \'pyproject.toml',
"             \'README',
"             \'README.md'
"             \'requirements.txt',
"             \'setup.py',
"             \]


Plug 'https://github.com/numToStr/Comment.nvim'

" Plug 'https://github.com/hynek/vim-python-pep8-indent', {'for': 'python'}

" highlighting visual selections
Plug 'https://github.com/Pocco81/HighStr.nvim'
" Highlight several words in different colors simultaneously
let g:mw_no_mappings = 1
Plug 'https://github.com/inkarkat/vim-ingo-library'
Plug 'https://github.com/inkarkat/vim-mark'


" displays a popup with possible keybindings of the command you started typing
Plug 'https://github.com/folke/which-key.nvim'

" A file explorer tree for neovim written in lua
Plug 'https://github.com/kyazdani42/nvim-tree.lua'


" -- Git --

Plug 'https://github.com/tpope/vim-fugitive'

Plug 'https://github.com/lewis6991/gitsigns.nvim'

" Single tabpage interface for easily cycling through diffs for all modified files for any git rev
Plug 'https://github.com/sindrets/diffview.nvim'

" more pleasant editing on commit messages
Plug 'https://github.com/rhysd/committia.vim'

" A git commit browser in Vim
" Plug 'https://github.com/junegunn/gv.vim'

" GitHub extension for fugitive.vim
Plug 'https://github.com/tpope/vim-rhubarb'
" extension to fugitive.vim for gitlab support
" Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
" Add Bitbucket URL support to fugitive.vim's :Gbrowse command
" Plug 'https://github.com/tommcdo/vim-fubitive'

" One second to read GitHub code with vim
" Plug 'https://github.com/drzel/vim-repo-edit'


" -- Misc -

" Highlight, list and search todo comments in your projects
Plug 'https://github.com/folke/todo-comments.nvim'

" A better user experience for interacting with and manipulating Vim marks
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
Plug 'https://github.com/chentoast/marks.nvim'

" -- Vimwiki & Markdown --

Plug 'https://github.com/vimwiki/vimwiki'
Plug 'https://github.com/ElPiloto/telescope-vimwiki.nvim'

" Markdown live preview
Plug 'https://github.com/iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    let g:mkdp_auto_close = 0

" Neovim extension for zk
Plug 'https://github.com/mickael-menu/zk-nvim'

Plug 'https://github.com/preservim/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_toc_autofit = 1
    let g:vim_markdown_conceal_code_blocks = 0
    let g:vim_markdown_strikethrough = 1

" Additional highlights for markdown
Plug 'https://github.com/lukas-reineke/headlines.nvim'

" -- Misc --

" Run Async Shell Commands
Plug 'https://github.com/skywind3000/asyncrun.vim'

" Set of operators and textobjects to search/select/edit sandwiched texts
Plug 'https://github.com/machakann/vim-sandwich'

" Additional text objects
" Provides:
" iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
" inX anX AnX InX for next object
" ilX alX AlX IlX for previous (last) object
" ia aa Ia Aa for arguments; works with nX/lX as well
Plug 'https://github.com/wellle/targets.vim'

" https://github.com/godlygeek/tabular
Plug 'https://github.com/godlygeek/tabular', { 'on': 'Tabularize' }

" Heuristically set buffer options
Plug 'https://github.com/tpope/vim-sleuth'

" Incremental fuzzy search motion plugin for Neovim
Plug 'https://github.com/rlane/pounce.nvim', { 'on': 'Pounce' }

" Terminal manager
Plug 'https://github.com/voldikss/vim-floaterm'
    " let g:floaterm_wintype = 'vsplit'
    let g:floaterm_height = 0.5
    let g:floaterm_width = 0.5
    let g:floaterm_position = 'bottomright'
    let g:floaterm_giteditor = 0

Plug 'https://github.com/jbyuki/venn.nvim'

Plug 'https://github.com/levouh/tint.nvim'

Plug 'https://github.com/sindrets/winshift.nvim'
Plug 'https://github.com/gbrlsnchs/winpick.nvim'

" hide gutter numbers for folds
Plug 'https://github.com/luukvbaal/statuscol.nvim'
" ultra fold
Plug 'https://github.com/kevinhwang91/nvim-ufo'

Plug 'https://github.com/lukas-reineke/indent-blankline.nvim'

" Inversed J
Plug 'https://github.com/AckslD/nvim-trevJ.lua/'

Plug 'https://github.com/kiran94/s3edit.nvim', { 'on': 'S3Edit' }

" Broken, revisit when updated
" Plug 'https://github.com/nvim-zh/colorful-winsep.nvim'

Plug 'https://github.com/tweekmonster/startuptime.vim'

" Easily add additional highlights to your buffers
Plug 'https://github.com/folke/paint.nvim'

" Neovim file explorer: edit your filesystem like a buffer
Plug 'https://github.com/stevearc/oil.nvim'

" Embed Neovim in Chrome, Firefox & others.
Plug 'https://github.com/glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Nvim lua plugin which adds support for twoslash queries into typescript projects
Plug 'https://github.com/marilari88/twoslash-queries.nvim'

Plug 'https://github.com/gen740/SmoothCursor.nvim'

Plug 'https://github.com/stevearc/overseer.nvim'

Plug 'https://github.com/rcarriga/nvim-notify'

Plug 'https://github.com/vinnymeller/swagger-preview.nvim'

call plug#end()

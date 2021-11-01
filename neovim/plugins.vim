" install plug.vim
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')

" -- LSP --

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

" A small Neovim plugin for previewing definitions using floating windows
" https://github.com/rmagatti/goto-preview
Plug 'rmagatti/goto-preview'

Plug 'RishabhRD/popfix'
" https://github.com/RishabhRD/nvim-lsputils
Plug 'RishabhRD/nvim-lsputils'

" https://github.com/onsails/lspkind-nvim
Plug 'onsails/lspkind-nvim'

" Display Neovim LSP diagnostics in ALE
" https://github.com/nathanmsmith/nvim-ale-diagnostic
Plug 'nathanmsmith/nvim-ale-diagnostic'

Plug 'kosayoda/nvim-lightbulb'

Plug 'folke/lsp-colors.nvim'

Plug 'folke/trouble.nvim'

" -- Completion --

" nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
" https://github.com/quangnguyen30192/cmp-nvim-tags
Plug 'quangnguyen30192/cmp-nvim-tags'
" https://github.com/hrsh7th/cmp-path
Plug 'hrsh7th/cmp-path'
" https://github.com/tzachar/cmp-tabnine
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" https://github.com/ray-x/cmp-treesitter
Plug 'ray-x/cmp-treesitter'
" https://github.com/hrsh7th/cmp-omni
Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/nvim-cmp'

" -- Treesitter --

Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'windwp/nvim-ts-autotag'
" Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat','do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : '0.5-compat'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" https://github.com/David-Kunz/treesitter-unit/
Plug 'David-Kunz/treesitter-unit/'



Plug 'michaeljsmith/vim-indent-object'

" TODO: revisit in future
" https://github.com/Jason-M-Chan/ts-textobjects
"Plug 'Jason-M-Chan/ts-textobjects'


" -- Telescope --

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }


" -- Colorschemes --
" Plug 'sainnhe/everforest'
" Plug 'embark-theme/vim', { 'as': 'embark' }
" Plug 'haishanh/night-owl.vim'
" Plug 'wuelnerdotexe/vim-enfocado', { 'branch' : 'development' }
" https://github.com/projekt0n/github-nvim-theme
Plug 'projekt0n/github-nvim-theme'
" https://github.com/fxn/vim-monochrome
"Plug 'fxn/vim-monochrome'


" Highlights the line of the cursor only in the current window
" https://github.com/miyakogi/conoline.vim
" Plug 'miyakogi/conoline.vim'
"     let g:conoline_auto_enable = 1
"     let g:conoline_use_colorscheme_default_normal=1
"     let g:conoline_use_colorscheme_default_insert=1


Plug 'lewis6991/gitsigns.nvim'

" global statusline on floating window
" https://github.com/windwp/floatline.nvim
" NOTE: check later, doesn't work very well as of 2021-09-30
" Plug 'windwp/floatline.nvim'

Plug 'karb94/neoscroll.nvim'

" highlight yanked region
" Plug 'machakann/vim-highlightedyank'
" TODO: replace with:
" augroup highlight_yank
"     autocmd!
"     au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
" augroup END

" underline word under cursor
" https://github.com/itchyny/vim-cursorword
" Plug 'itchyny/vim-cursorword'
"     let g:cursorword_highlight = 1

" Semantic highlight
" https://github.com/jaxbot/semantic-highlight.vim
Plug 'jaxbot/semantic-highlight.vim'
    " autocmd BufEnter * SemanticHighlight

" Readline style insertion
Plug 'tpope/vim-rsi'

" disables search highlighting when you are done searching and re-enables it when you search again
Plug 'romainl/vim-cool'

" Range, pattern and substitute preview
Plug 'markonm/traces.vim'
    let g:traces_normal_preview = 1

" Close brackets on enter
" Config: https://github.com/rstacruz/vim-closer/blob/master/plugin/closer.vim
"Plug 'rstacruz/vim-closer'

" handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
Plug 'kopischke/vim-fetch'

" guess file indentation style
" XXX: causes red indent highlights :shrug:
" Plug 'conormcd/matchindent.vim'

" auto-generate ctags file
Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_project_root = [
        \'docker-compose.yml',
        \'Makefile',
        \'pyproject.toml',
        \'.python-version',
        \'README',
        \'README.md'
        \'requirements.txt',
        \'setup.py',
    \]

Plug 'tpope/vim-commentary'

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

Plug 'davidhalter/jedi-vim', {'for': 'python'}
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 0

    let g:jedi#goto_command = '<leader>jg'
    let g:jedi#goto_assignments_command = '<leader>ja'
    let g:jedi#goto_definitions_command = '<leader>jd'
    let g:jedi#goto_stubs_command = '<leader>js'
    let g:jedi#usages_command = '<leader>ju'
    let g:jedi#rename_command = '<leader>jr'

    " autocmd FileType python setlocal completeopt-=preview

" Generate Python docstring to your Python source code
" https://github.com/heavenshell/vim-pydocstring
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
    let g:pydocstring_enable_mapping = 0
    let g:pydocstring_ignore_init = 1
    let g:pydocstring_formatter = 'google'
    let g:pydocstring_doq_path = '/home/tomasz/.local/bin/doq'
    let g:pydocstring_templates_path = '/home/tomasz/.dotfiles/doq'
    nnoremap <Leader>pd :Pydocstring<CR>
    xnoremap <Leader>pd :Pydocstring<CR>
    nnoremap <Leader>pD :PydocstringFormat<CR>

" Highlight and navigate multiple words
" https://github.com/lfv89/vim-interestingwords
Plug 'lfv89/vim-interestingwords'
    let g:interestingWordsDefaultMappings = 0
    nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
    vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
    nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
    " let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
    let g:interestingWordsTermColors = [
                \ '1', '2', '3', '4', '5', '6', '9', '63', '75', '81', '85', '87',
                \ '99', '108', '115', '125', '137', '141', '142', '154',
                \ '159', '165', '167', '175', '202', '207', '208', '211', '214', '219',
                \ '226', '228'
                \ ]
    let g:interestingWordsRandomiseColors = 1

" https://github.com/dense-analysis/ale
" let g:ale_set_balloons = 1
Plug 'dense-analysis/ale'
    let g:ale_linters = {
                \ 'python': ['mypy', 'flake8'],
                \}
                "\'javascript': ['eslint', 'deno'],
                " \'javascript': [],
                " \'vue': [],
    let g:ale_fixers = {
                \'bash': ['shfmt'],
                \'python': ['isort', 'black'],
                \'sh': ['shfmt'],
                \}
                " \'javascript': ['eslint'],
                " \'typescript': ['eslint'],
    let g:ale_fix_on_save = 1
    let g:ale_lint_on_text_chaned = 1
    let g:ale_lint_on_enter = 1
    let g:ale_virtualenv_dir_names = ['venv', '.venv']
    let g:ale_python_pylint_use_global = 0
    let g:ale_python_auto_poetry = 1
    let g:ale_python_flake8_options = '--max-line-length 88'
    let g:ale_python_pydocstyle_options = '--convention=google'
    " let g:ale_completion_enabled = 1
    let g:ale_echo_msg_format = '[%linter% %severity%] %code: %%s'
    let g:ale_virtualtext_cursor = 1
    let g:ale_virtualtext_prefix = '  ■ '
    " let g:ale_cursor_detail = 1
    " let g:ale_close_preview_on_insert = 1
    " let g:ale_hover_to_preview = 1
     let g:ale_floating_preview = 1
    " let g:ale_hover_to_floating_preview = 1
    let g:ale_detail_to_floating_preview = 1
    let g:ale_lsp_suggestions = 0
    " set omnifunc=ale#completion#OmniFunc
    " if executable('pyls')
    "     au User lsp_setup call lsp#register_server({
    "         \ 'name': 'pyls',
    "         \ 'cmd': {server_info->['pyls']},
    "         \ 'whitelist': ['python'],
    "         \ })
    " endif

	" TOP_LEFT = '┌',
	" TOP_RIGHT = '┐',
	" MID_HORIZONTAL = '─',
	" MID_VERTICAL = '│',
	" BOTTOM_LEFT = '└',
	" BOTTOM_RIGHT = '┘',
    " the horizontal, top, top-left, top-right, bottom-right and bottom-left
    let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
    let g:ale_sign_error = ''
    let g:ale_sign_warning = ''
    let g:ale_sign_info = '🗩'
    let g:ale_sign_style_error = ''
    let g:ale_sign_style_warning = ''


Plug 'mizlan/iswap.nvim'

" Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is
" https://github.com/DanilaMihailov/beacon.nvim
Plug 'danilamihailov/beacon.nvim'
    let g:beacon_shrink = 0
    let g:beacon_timeout = 200

Plug 'blueyed/vim-diminactive'
    let g:diminactive_use_colorcolumn = 1
    let g:diminactive_use_syntax = 0

" Plug 'TaDaa/vimade'
"     let g:vimade = {}
"     let g:vimade.fadelevel = 0.7
"     let g:vimade.enablesigns = 1
"     let g:vimade.enabletreesitter = 1

" Simple statusline component that shows what scope you are working inside
" https://github.com/SmiteshP/nvim-gps
Plug 'SmiteshP/nvim-gps'

" displays a popup with possible keybindings of the command you started typing
" https://github.com/folke/which-key.nvim
Plug 'folke/which-key.nvim'

" A more adventurous wildmenu
" https://github.com/gelguy/wilder.nvim
" NOTE: python3/pynvim/msgpack issues in venv
"Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

" Plug 'hoob3rt/lualine.nvim' " unmaintained
" https://github.com/shadmansaleh/lualine.nvim
Plug 'shadmansaleh/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" A file explorer tree for neovim written in lua
" https://github.com/kyazdani42/nvim-tree.lua
Plug 'kyazdani42/nvim-tree.lua'
    let g:nvim_tree_ignore = [
        \ '.git',
        \ 'node_modules',
        \ '.cache',
        \ '.mypy_cache',
        \ 'tags'
        \ ]
    let g:nvim_tree_highlight_opened_files = 1
    let g:nvim_tree_add_trailing = 1
    let g:nvim_tree_special_files = {
            \ 'README.md': 1,
            \ 'TODO.txt': 1,
            \ 'TODO.md': 1
            \ }


" -- Git --

" more pleasant editing on commit messages
" https://github.com/rhysd/committia.vim
Plug 'rhysd/committia.vim'

" Highlight, list and search todo comments in your projects
" https://github.com/folke/todo-comments.nvim
Plug 'folke/todo-comments.nvim'

" Peek lines just when you intend
" https://github.com/nacro90/numb.nvim
Plug 'nacro90/numb.nvim'

" -- Vimwiki --

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
" https://github.com/ElPiloto/telescope-vimwiki.nvim
Plug 'ElPiloto/telescope-vimwiki.nvim'

call plug#end()

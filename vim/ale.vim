" https://github.com/dense-analysis/ale
" let g:ale_set_balloons = 1
Plug 'dense-analysis/ale'
let g:ale_linters = {
            \ 'python': ['mypy', 'flake8', 'pylint']
            \}
let g:ale_fixers = {
            \'bash': ['shfmt'],
            \'python': ['black', 'isort'],
            \'sh': ['shfmt'],
            \}
let g:ale_fix_on_save = 1
let g:ale_python_pylint_use_global = 0
let g:ale_python_auto_poetry = 1
let g:ale_python_flake8_options = '--max-line-length 88'
let g:ale_python_pydocstyle_options = '--convention=google'
nnoremap ]} :ALENext<CR>
nnoremap [{ :ALEPrevious<CR>
nnoremap <Leader>aT :ALEToggle<CR>
nnoremap <Leader>aa :lopen<CR>
nnoremap <Leader>ad :ALEDetail<CR>
nnoremap <Leader>aD :let g:ale_cursor_detail = g:ale_cursor_detail * -1 + 1<CR>
nnoremap <Leader>af :ALEFix<CR>
nnoremap <Leader>ah :ALEHover<C>
nnoremap <Leader>al :ALELint<CR>
nnoremap <Leader>at :ALEToggleBuffer<CR>
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '[%linter% %severity%] %code: %%s'
" set mouse=a
" set ttymouse=xterm
let g:ale_cursor_detail = 1
let g:ale_close_preview_on_insert = 1
let g:ale_hover_to_preview = 1
let g:ale_floating_preview = 1
" let g:ale_hover_to_floating_preview = 1
" let g:ale_detail_to_floating_preview = 1
let g:ale_floating_window_border = []
set omnifunc=ale#completion#OmniFunc
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif


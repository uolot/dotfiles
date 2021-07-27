Plug 'hdima/python-syntax', {'for': 'python'}

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

Plug 'davidhalter/jedi-vim', {'for': 'python'}
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 0

    let g:jedi#goto_command = '<leader>gg'
    let g:jedi#goto_assignments_command = '<leader>ga'
    let g:jedi#goto_definitions_command = '<leader>gd'
    let g:jedi#goto_stubs_command = '<leader>gs'
    let g:jedi#usages_command = '<leader>gu'
    let g:jedi#rename_command = '<leader>gr'

    autocmd FileType python setlocal completeopt-=preview

" autocmd FileType python set autoread
" autocmd FileType python let b:dispatch = 'isort % ; black %'
" autocmd BufWritePost *.py Dispatch!
" autocmd CursorHold * if getcmdwintype() == '' | checktime | endif
" autocmd BufWritePost *.py checktime

autocmd FileType python iabbrev ifmain if __name__ == "__main__"
autocmd FileType python iabbrev adef async def
autocmd FileType python iabbrev awith async with
autocmd FileType python iabbrev bp breakpoint()

" Poor man's snippets
autocmd FileType python nnoremap <Leader><Space>bp obreakpoint()<CR><Esc>
autocmd FileType python nnoremap <Leader><Space>doc o"""<CR>"""<Esc>kA
autocmd FileType python nnoremap <Leader><Space>nq A  # noqa<Esc>
autocmd FileType python nnoremap <Leader><Space>pd A  # pylint: disable=
autocmd FileType python nnoremap <Leader><Space>ti A  # type: ignore<Esc>
autocmd FileType python nnoremap <Leader><Space>todo O# TODO: 

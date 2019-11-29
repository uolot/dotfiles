Plug 'hdima/python-syntax', {'for': 'python'}

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

Plug 'davidhalter/jedi-vim', {'for': 'python'}
    let g:jedi#popup_on_dot = 1

    let g:jedi#goto_command = '<leader>jg'
    let g:jedi#goto_assignments_command = '<leader>ja'
    let g:jedi#goto_definitions_command = '<leader>jd'
    let g:jedi#rename_command = '<leader>jr'
    let g:jedi#usages_command = '<leader>ju'
    let g:jedi#goto_stubs_command = '<leader>js'

    autocmd FileType python setlocal completeopt-=preview

" TODO: try https://github.com/wbolster/black-macchiato
" Plug 'psf/black', {'for': 'python'}
"      " let g:black_linelength = 100
"      " let g:black_skip_string_normalization = 1
"      " let g:black_virtualenv = '~/.local'
"      " let g:black_virtualenv = '~/.local/pipx/venvs/black'
"      " let g:black_virtualenv = '/usr'

"      function! BlackEnable()
"          if !exists("g:black_on_save_enabled")
"              let g:black_on_save_enabled = 1
"              echo "Enabled Black on save"
"          else
"              echo "Black on save was already enabled"
"          endif
"      endfunction
"      command BlackEnable call BlackEnable()

"      function! BlackDisable()
"          if exists("g:black_on_save_enabled")
"              unlet g:black_on_save_enabled
"              echo "Disabled Black on save"
"          endif
"      endfunction
"      command BlackDisable call BlackDisable()

"      function! BlackRun()
"          if exists("g:black_on_save_enabled")
"              execute ':Black'
"          endif
"      endfunction
"      command BlackRun call BlackRun()

"      " enable black by default
"      let g:black_on_save_enabled = 0
"      autocmd BufWritePre *.py execute ':BlackRun'

autocmd BufWritePre *.py Dispatch! black %

autocmd FileType python iabbrev ifmain if __name__ == "__main__"

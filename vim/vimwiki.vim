Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [
    \ {'path': '~/.vimwiki/', 'auto_tags': 1, 'auto_diary_index': 1, 'auto_export': 1, 'auto_toc': 1},
    \ {'path': '~/Build/vimwikiwiki/wiki', 'path_html': '~/Build/vimwikiwiki/docs', 'auto_toc': 1},
    \ ]

function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

" https://vimwiki.github.io/vimwikiwiki/Tips%20and%20Snips.html#Tips%20and%20Snips-Task%20Management-Find%20Incomplete%20Tasks
nnoremap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nnoremap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

nmap glt I- [ ] <Esc>
vnoremap glt :'<,'>norm I- [ ] <CR>

nnoremap <Leader>wT :VimwikiTOC<CR>

let g:vimwiki_hl_cb_checked = 0

autocmd FileType vimwiki setlocal nowrap

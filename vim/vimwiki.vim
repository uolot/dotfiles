Plug 'vimwiki/vimwiki'

" TODO: test auto_generate_links and auto_generate_tags
"  see: https://github.com/vimwiki/vimwiki/pull/635

let wiki1 = {}
let wiki1.path = '~/.vimwiki'
let wiki1.maxhi = 1
let wiki1.auto_diary_index = 1
let wiki1.auto_export = 1
let wiki1.auto_generate_links = 1
let wiki1.auto_generate_tags = 1
let wiki1.auto_tags = 1
let wiki1.auto_toc = 1

let g:vimwiki_list = [wiki1]

let g:vimwiki_auto_chdir = 1
let g:vimwiki_auto_header = 1
" let g:vimwiki_conceal_pre = 1
let g:vimwiki_hl_cb_checked = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_list_ignore_newline = 1
let g:vimwiki_listsym_rejected = '-'
let g:vimwiki_listsyms = ' .x'
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_table_auto_fmt = 0
let g:vimwiki_text_ignore_newline = 0

function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

" See `:h vimwiki-local-mappings` for more details on remapping

" https://vimwiki.github.io/vimwikiwiki/Tips%20and%20Snips.html#Tips%20and%20Snips-Task%20Management-Find%20Incomplete%20Tasks

nnoremap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nnoremap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

nmap glt I- [ ] <Esc>
vnoremap glt :'<,'>norm I- [ ] <CR>

nnoremap <Leader>wg :VimwikiGoto 
nnoremap <Leader>wf :Files ~/.vimwiki/<CR>
nnoremap <Leader>w/ :VimwikiSearch 
nnoremap <Leader>wT :VimwikiTOC<CR>
nnoremap <Leader>wq :VimwikiGoto Scratchpad<CR>
nmap <Leader>ws <Plug>VimwikiSplitLink
nmap <Leader>wv <Plug>VimwikiVSplitLink
nnoremap <Leader>wl :VimwikiRenumberList<CR>

autocmd FileType vimwiki setlocal nowrap

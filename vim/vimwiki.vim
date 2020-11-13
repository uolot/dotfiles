Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" Contents
" 01 Vimwiki wikis
" 02 Vimwiki config
" 03 Vimwiki mappings

" 01 Vimwiki wikis

let wiki1 = {}
let wiki1.path = '~/Vimwiki/wiki/'
let wiki1.path_html = '~/Vimwiki/html/'
let wiki1.template_path = '~/Vimwiki/templates/'
let wiki1.template_default = 'def_template'
let wiki1.template_ext = '.html'
let wiki1.maxhi = 1
let wiki1.auto_diary_index = 1
let wiki1.auto_export = 1
let wiki1.auto_generate_links = 1
let wiki1.auto_generate_tags = 1
let wiki1.auto_tags = 1
let wiki1.auto_toc = 1
let wiki1.diary_frequency = "daily"

let g:vimwiki_list = [wiki1]

" 02 Vimwiki config

let g:vimwiki_auto_chdir = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_emoji_enable = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_cb_checked = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_list_ignore_newline = 1
let g:vimwiki_listsym_rejected = '-'
let g:vimwiki_listsyms = ' .x'
let g:vimwiki_markdown_link_ext = 0
let g:vimwiki_table_auto_fmt = 1
let g:vimwiki_text_ignore_newline = 0
let g:vimwiki_toc_link_format = 1
let g:vimwiki_url_maxsave = 50

function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

" 03 Vimwiki mappings

nnoremap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nnoremap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

" convert list item to a task
nnoremap gtt m`0^a [ ]<Esc>``

" delete task box
nnoremap gtu m`0f[Xd%``

" mark task done
nnoremap gt<Space> m`0f[lrxf]a DONE :YMD<C-]>:<Esc><C-Space>``

" mark task cancelled
nnoremap gtc m`0f[lrxf]a CANCELLED :YMD<C-]>:<Esc>glx``

nnoremap <Leader>wg :VimwikiGoto 
nnoremap <Leader>wf :Files ~/Vimwiki/wiki/<CR>
nnoremap <Leader>w/ :VimwikiSearch 
nnoremap <Leader>wT :VimwikiTOC<CR>
nnoremap <Leader>wq :VimwikiGoto Scratchpad<CR>
nmap <Leader>ws <Plug>VimwikiSplitLink
nmap <Leader>wv <Plug>VimwikiVSplitLink
nnoremap <Leader>wl :VimwikiRenumberList<CR>
" causes segfault - revisit later
" nnoremap <silent> <Leader>wu :call vimwiki#base#linkify()<CR>

autocmd FileType vimwiki setlocal textwidth=100 nowrap linebreak nolist wrapmargin=0

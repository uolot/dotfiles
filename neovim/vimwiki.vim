" Contents
" 01 Vimwiki wikis
" 02 Vimwiki config
" 03 Vimwiki mappings

" 01 Vimwiki wikis

let wiki1 = {}
let wiki1.name = 'Main'
let wiki1.path = '~/Vimwiki/wiki/'
let wiki1.path_html = '~/Vimwiki/html/'
let wiki1.template_path = '~/Vimwiki/templates/'
let wiki1.template_default = 'def_template'
let wiki1.template_ext = '.html'
let wiki1.maxhi = 1
let wiki1.auto_diary_index = 1
let wiki1.auto_export = 1
let wiki1.auto_generate_links = 1
let wiki1.auto_tags = 1
let wiki1.auto_toc = 1
let wiki1.diary_frequency = "daily"

let wiki2 = {}
let wiki2.name = 'Lyst'
let wiki2.path = '~/Vimwiki/lyst/wiki/'
let wiki2.path_html = '~/Vimwiki/lyst/html/'
let wiki2.template_path = '~/Vimwiki/templates/'
let wiki2.template_default = 'def_template'
let wiki2.template_ext = '.html'
let wiki2.maxhi = 1
let wiki2.auto_export = 1
let wiki2.auto_generate_links = 1
let wiki2.auto_tags = 1
let wiki2.auto_toc = 1
let wiki2.diary_frequency = "daily"

let wiki3 = {}
let wiki3.name = 'EH'
let wiki3.path = '~/Vimwiki/eh/wiki/'
let wiki3.path_html = '~/Vimwiki/eh/html/'
let wiki3.template_path = '~/Vimwiki/templates/'
let wiki3.template_default = 'def_template'
let wiki3.template_ext = '.html'
let wiki3.maxhi = 1
let wiki3.auto_export = 1
let wiki3.auto_generate_links = 1
let wiki3.auto_tags = 1
let wiki3.auto_toc = 1
let wiki3.diary_frequency = "daily"



let g:vimwiki_list = [wiki1, wiki2, wiki3]

" 02 Vimwiki config

let g:vimwiki_auto_chdir = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_emoji_enable = 0
" let g:vimwiki_folding = 'list'
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_cb_checked = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_list_ignore_newline = 1
let g:vimwiki_listsym_propagate = 0
let g:vimwiki_listsym_rejected = '-'
let g:vimwiki_listsyms = ' .x'
let g:vimwiki_markdown_link_ext = 0
let g:vimwiki_table_auto_fmt = 1
let g:vimwiki_text_ignore_newline = 0
let g:vimwiki_toc_link_format = 1
let g:vimwiki_url_maxsave = 50

" 03 Vimwiki mappings

" nnoremap <Leader>wf :Files ~/Vimwiki/wiki/<CR>
nnoremap <silent> <Leader>wf :Telescope vimwiki<CR>
nnoremap <silent> <Leader>wl :Telescope vimwiki live_grep<CR>
nnoremap <Leader>wg :VimwikiGoto 
nmap <Leader>ws <Plug>VimwikiSplitLink
nmap <Leader>wv <Plug>VimwikiVSplitLink

autocmd FileType vimwiki setlocal textwidth=100 nowrap linebreak nolist wrapmargin=0

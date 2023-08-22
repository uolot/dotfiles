" reversed J
nmap <silent> K :lua require('trevj').format_at_cursor()<CR>

" reselect visual block after (un)indent
vnoremap < <gv
vnoremap > >gv

" select inserted/pasted text
nnoremap gV `[v`]

" fast buffer switching
nnoremap <Backspace> <C-^>

" make dot work over visual line selections
xnoremap . :norm.<CR>
" execute a macro over visual line selections
xnoremap Q :'<,'>:normal @q<CR>

" use very-magic mode for search regex
" nnoremap / /\v
" nnoremap ? ?\v

nnoremap zR <Cmd>lua require('ufo').openAllFolds()<CR>
nnoremap zM <Cmd>lua require('ufo').closeAllFolds()<CR>

inoremap <C-Tab> <C-n>
inoremap <C-S-Tab> <C-p>

augroup markdown_mappings
    autocmd FileType markdown nmap ]] <Plug>Markdown_MoveToNextSiblingHeader
    autocmd FileType markdown nmap [[ <Plug>Markdown_MoveToPreviousSiblingHeader
    autocmd FileType markdown nmap ]h <Plug>Markdown_MoveToNextHeader
    autocmd FileType markdown nmap [h <Plug>Markdown_MoveToPreviousHeader
    autocmd FileType markdown nmap ]u <Plug>Markdown_MoveToParentHeader
    autocmd FileType markdown nmap [u <Plug>Markdown_MoveToParentHeader
    autocmd FileType markdown nmap <silent> + :.HeaderIncrease<CR>
    autocmd FileType markdown nmap <silent> - :.HeaderDecrease<CR>
    autocmd FileType markdown nmap <silent> <Leader>mf :TableFormat<CR>
    autocmd FileType markdown nmap <silent> <Leader>mp :MarkdownPreviewToggle<CR>
    autocmd FileType markdown nmap <silent> <Leader>mt :Toc<CR>
    autocmd FileType markdown nmap <silent> <Leader>mT :InsertToc<CR>
augroup end

" vsnip
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

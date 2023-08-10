" oil
    nnoremap <silent> <Leader>n- <Cmd>lua require("oil").open()<CR>

" zk
    " normal
    nnoremap <Leader>zf :ZkNotes<CR>
    nnoremap <Leader>zc :lua vim.ui.input({ prompt = "Title: " }, function(i) vim.cmd('ZkNew {title="' .. i .. '"}') end)<CR>
    nnoremap <Leader>zn :lua vim.ui.input({ prompt = "Title: " }, function(i) vim.cmd('ZkNew {title="' .. i .. '"}') end)<CR>
    nnoremap <Leader>zl :ZkLinks<CR>
    nnoremap <Leader>zb :ZkBacklinks<CR>
    nnoremap <Leader>zt :ZkTags<CR>
    " visual
    xnoremap <Leader>zn :ZkNewFromTitleSelection<CR>
    " TODO: Ask for title when creating content from selection
    " xnoremap <Leader>zC :ZkNewFromContentSelection<CR>
    xnoremap <Leader>zm :ZkMatch<CR>

" diffview
    nnoremap <Leader>df <Cmd>DiffviewFileHistory %<CR>
    nnoremap <Leader>dc <Cmd>DiffviewClose<CR>
    nnoremap <Leader>do <Cmd>DiffviewOpen<CR>

" jump between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" reversed J
nmap <silent> K :lua require('trevj').format_at_cursor()<CR>

" switch between buffers
nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" quickfix navigation
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>

" todo navigation
nnoremap <silent> ]t <Cmd>lua require("todo-comments").jump_next()<CR>
nnoremap <silent> [t <Cmd>lua require("todo-comments").jump_prev()<CR>

" jest tests
nnoremap <silent> [j ?^\s\+\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\)\><CR>
nnoremap <silent> ]j /^\s\+\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\)\><CR>

" insert blank lines
nnoremap gO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap go  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

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
augroup end

" vsnip
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

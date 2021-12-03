" toggles
    " nnoremap <Leader>xa :ALEToggle<CR>
    nnoremap <Leader>xcl :set background=light \| colorscheme github_light<CR>
    nnoremap <Leader>xcd :set background=dark \| colorscheme github_dimmed<CR>
    nnoremap <Leader>xd1 :lua vim.diagnostic.show()<CR>
    nnoremap <Leader>xd0 :lua vim.diagnostic.hide()<CR>
    nnoremap <Leader>xw :set wrap!<CR>

" lsp
    nnoremap <silent> ]d :lua vim.diagnostic.goto_next({ wrap = false })<CR>
    nnoremap <silent> [d :lua vim.diagnostic.goto_prev({ wrap = false })<CR>
    inoremap <silent> <C-s> <Cmd>lua vim.lsp.buf.signature_help()<CR>
    " nnoremap <silent> <Leader>ga :lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <Leader>ga <Cmd>CodeActionMenu<CR>
    " vnoremap <silent> <Leader>ga :<C-u>lua vim.lsp.buf.range_code_action()<CR>
    vnoremap <silent> <Leader>ga <Cmd>CodeActionMenu<CR>
    nnoremap <silent> <Leader>ge :lua vim.diagnostic.open_float()<CR>
    nnoremap <silent> <Leader>gd :lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <Leader>gD :lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <Leader>gf :Telescope lsp_references<CR>
    nnoremap <silent> <Leader>gF :lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <Leader>gh :lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <Leader>gi :lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <Leader>gr :Telescope lsp_references<CR>
    nnoremap <silent> <Leader>gR :lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <Leader>gs :Telescope lsp_document_symbols<CR>
    nnoremap <silent> <Leader>gS :Telescope lsp_dynamic_workspace_symbols<CR>
    nnoremap <silent> <Leader>gt :lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <Leader>gu :lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <Leader>gwa :lua vim.lsp.buf.add_workspace_folder()<CR>
    nnoremap <silent> <Leader>gwr :lua vim.lsp.buf.remove_workspace_folder()<CR>
    nnoremap <silent> <Leader>gwl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
    nnoremap <silent> <Leader>gx :TroubleToggle document_diagnostics<CR>
    nnoremap <silent> <Leader>gX :TroubleToggle workspace_diagnostics<CR>

" " ale
    " nnoremap ]} :ALENext<CR>
    " nnoremap [{ :ALEPrevious<CR>
    " nnoremap <Leader>ae :ALEDetail<CR>
    " nnoremap <Leader>af :ALEFix<CR>
    " nnoremap <Leader>ah :ALEHover<CR>
    " nnoremap <Leader>al :ALELint<CR>
    " nnoremap <Leader>at :ALEToggleBuffer<CR>
    " " nnoremap <Leader>aa :lopen<CR>
    " " nnoremap <Leader>aD :let g:ale_cursor_detail = g:ale_cursor_detail * -1 + 1<CR>

" telescope
    nnoremap <silent> <Leader>ff :Telescope find_files<CR>
    nnoremap <silent> <Leader>fgb :Telescope git_branches<CR>
    nnoremap <silent> <Leader>fgc :Telescope git_bcommits<CR>
    nnoremap <silent> <Leader>fgC :Telescope git_commits<CR>
    nnoremap <silent> <Leader>fgf :Telescope git_files<CR>
    nnoremap <silent> <Leader>fgs :Telescope git_status<CR>
    nnoremap <silent> <Leader>fgS :Telescope git_stash<CR>
    nnoremap <silent> <Leader>fo :Telescope oldfiles<CR>

" more telescope
    nnoremap <silent> <Leader>tb :Telescope buffers<CR>
    nnoremap <silent> <Leader>td :TodoTelescope<CR>
    nnoremap <silent> <Leader>te :Telescope emoji<CR>
    nnoremap <silent> <Leader>tf :Telescope current_buffer_fuzzy_find<CR>
    nnoremap <silent> <Leader>tg :Telescope grep_string<CR>
    nnoremap <silent> <Leader>tl :Telescope live_grep<CR>
    nnoremap <silent> <Leader>tt :Telescope current_buffer_tags<CR>
    nnoremap <silent> <Leader>tT :Telescope tags<CR>

" nvim-tree
    nnoremap <silent> <Leader>nc :NvimTreeClose<CR>
    nnoremap <silent> <Leader>nf :NvimTreeFindFile<CR>
    nnoremap <silent> <Leader>nn :NvimTreeToggle<CR>
    nnoremap <silent> <Leader>nr :NvimTreeRefresh<CR>
    nnoremap <silent> <Leader>nt :NvimTreeFocus<CR>

" colour - HSHighlight / vim-mark
    " visual
    vnoremap <silent> <Leader>k1 :<c-u>HSHighlight 1<CR>
    vnoremap <silent> <Leader>k2 :<c-u>HSHighlight 2<CR>
    vnoremap <silent> <Leader>k3 :<c-u>HSHighlight 3<CR>
    vnoremap <silent> <Leader>k4 :<c-u>HSHighlight 4<CR>
    vnoremap <silent> <Leader>k5 :<c-u>HSHighlight 5<CR>
    vnoremap <silent> <Leader>k6 :<c-u>HSHighlight 6<CR>
    vnoremap <silent> <Leader>k7 :<c-u>HSHighlight 7<CR>
    vnoremap <silent> <Leader>k8 :<c-u>HSHighlight 8<CR>
    vnoremap <silent> <Leader>k9 :<c-u>HSHighlight 9<CR>
    " normal
    nnoremap <silent> <Leader>k1 V:<c-u>HSHighlight 1<CR>
    nnoremap <silent> <Leader>k2 V:<c-u>HSHighlight 2<CR>
    nnoremap <silent> <Leader>k3 V:<c-u>HSHighlight 3<CR>
    nnoremap <silent> <Leader>k4 V:<c-u>HSHighlight 4<CR>
    nnoremap <silent> <Leader>k5 V:<c-u>HSHighlight 5<CR>
    nnoremap <silent> <Leader>k6 V:<c-u>HSHighlight 6<CR>
    nnoremap <silent> <Leader>k7 V:<c-u>HSHighlight 7<CR>
    nnoremap <silent> <Leader>k8 V:<c-u>HSHighlight 8<CR>
    nnoremap <silent> <Leader>k9 V:<c-u>HSHighlight 9<CR>
    " word
    nmap <Leader>kk <Plug>MarkSet
    xmap <Leader>kk <Plug>MarkSet
    nmap <Leader>kK <Plug>MarkClear
    nmap <Leader>km <Plug>MarkToggle
    " clear selection
    vnoremap <silent> <Leader>kx :<c-u>HSRmHighlight<CR>
    nnoremap <silent> <Leader>kx V:<c-u>HSRmHighlight<CR>
    nnoremap <silent> <Leader>kX :<c-u>HSRmHighlight rm_all<CR>

" zk
    " normal
    nnoremap <Leader>zf :ZkNotes<CR>
    nnoremap <Leader>zc :lua vim.ui.input("Title: ", function(i) vim.cmd('ZkNew {title="' .. i .. '"}') end)<CR>
    " FIXME:
    " nnoremap <Leader>zc :lua <Cmd>ZkNew {title=vim.fn.input('Title: ')}<CR>
    " nnoremap <Leader>zn :lua <Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>
    " lua vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { noremap=true, silent=false });
    nnoremap <Leader>zl :ZkLinks<CR>
    nnoremap <Leader>zb :ZkBacklinks<CR>
    nnoremap <Leader>zt :ZkTags<CR>
    " visual
    xnoremap <Leader>zn :ZkNewFromTitleSelection<CR>
    " TODO: Ask for title when creating content from selection
    " xnoremap <Leader>zC :ZkNewFromContentSelection<CR>
    xnoremap <Leader>zm :ZkMatch<CR>

" search
    " pounce
    nnoremap <Leader>jj <cmd>Pounce<CR>
    nnoremap <Leader>jn <cmd>PounceRepeat<CR>
    vnoremap <Leader>jj <cmd>Pounce<CR>
    onoremap <Leader>jj <cmd>Pounce<CR>
    " case-insensitive search
    nnoremap <Leader>/ /\c
    " search for word (like grep -w)
    nnoremap <Leader>s /\<\><left><left>
    " make n/N always go in the same direction
    noremap <expr> <SID>(search-forward) 'Nn'[v:searchforward]
    noremap <expr> <SID>(search-backward) 'nN'[v:searchforward]
    nmap n <SID>(search-forward)
    xmap n <SID>(search-forward)
    nmap N <SID>(search-backward)
    xmap N <SID>(search-backward)

" jump between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" switch between buffers
nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" quickfix navigation
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>

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


" toggles
    nnoremap <Leader>xw :set wrap!<CR>
    " nnoremap <Leader>xW :call wilder#toggle()<CR>
    nnoremap <Leader>xcl :set background=light \| colorscheme github_light<CR>
    nnoremap <Leader>xcd :set background=dark \| colorscheme github_dimmed<CR>
    nnoremap <Leader>xa :ALEToggle<CR>

" lsp
    " diagnostic
    nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
    nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
    nnoremap <silent> ]l :Lspsaga diagnostic_jump_next<CR>
    nnoremap <silent> [. :Lspsaga diagnostic_jump_prev<CR>

    inoremap <silent> <C-k> <Cmd>lua vim.lsp.buf.signature_help()<CR>
    " inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>

    " nnoremap <silent> <Leader>ga :Lspsaga code_action<CR>
    nnoremap <silent> <Leader>ga :lua vim.lsp.buf.code_action()<CR>
    " vnoremap <silent> <Leader>ga :<C-u>Lspsaga range_code_action<CR>
    vnoremap <silent> <Leader>ga :<C-u>lua vim.lsp.buf.range_code_action()<CR>
    nnoremap <silent> <Leader>ge :Lspsaga show_line_diagnostics<CR>
    nnoremap <silent> <Leader>gd :lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <Leader>gD :lua vim.lsp.buf.declaration()<CR>
    " nnoremap <silent> <Leader>gf :Lspsaga lsp_finder<CR>
    nnoremap <silent> <Leader>gf :Telescope lsp_references<CR>
    nnoremap <silent> <Leader>gF :lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <Leader>gh :lua vim.lsp.buf.hover()<CR>
    " nnoremap <silent> <Leader>gh :Lspsaga hover_doc<CR>
    nnoremap <silent> <Leader>gi :lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <Leader>gp :Lspsaga preview_definition<CR>
    nnoremap <silent> <Leader>gR :Lspsaga rename<CR>
    " nnoremap <silent> <Leader>gR :lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <Leader>gs :lua vim.lsp.buf.signature_help()<CR>
    " nnoremap <silent> <Leader>gs :Lspsaga signature_help<CR>
    nnoremap <silent> <Leader>gt :lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <Leader>gu :lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <Leader>gx :LspTroubleDocumentToggle<CR>
    nnoremap <silent> <Leader>gX :LspTroubleToggle<CR>

" ale
    nnoremap ]} :ALENext<CR>
    nnoremap [{ :ALEPrevious<CR>
    nnoremap <Leader>ae :ALEDetail<CR>
    nnoremap <Leader>af :ALEFix<CR>
    nnoremap <Leader>ah :ALEHover<CR>
    nnoremap <Leader>al :ALELint<CR>
    nnoremap <Leader>at :ALEToggleBuffer<CR>
    " nnoremap <Leader>aa :lopen<CR>
    " nnoremap <Leader>aD :let g:ale_cursor_detail = g:ale_cursor_detail * -1 + 1<CR>

" telescope
    nnoremap <silent> <Leader>fb :Telescope buffers<CR>
    nnoremap <silent> <Leader>ff :Telescope find_files<CR>
    nnoremap <silent> <Leader>fg :Telescope grep_string<CR>
    nnoremap <silent> <Leader>fl :Telescope live_grep<CR>
    nnoremap <silent> <Leader>fo :Telescope oldfiles<CR>
    nnoremap <silent> <Leader>ft :Telescope current_buffer_tags<CR>
    nnoremap <silent> <Leader>fT :Telescope tags<CR>

" more telescope
    nnoremap <silent> <Leader>tc :Telescope git_bcommits<CR>
    nnoremap <silent> <Leader>td :TodoTelescope<CR>
    nnoremap <silent> <Leader>tf :Telescope current_buffer_fuzzy_find<CR>
    nnoremap <silent> <Leader>tr :Telescope lsp_references<CR>
    nnoremap <silent> <Leader>ts :Telescope lsp_dynamic_workspace_symbols<CR>
    nnoremap <silent> <Leader>tS :Telescope lsp_document_symbols<CR>

" edit
    nnoremap <silent> <Leader>ess :ISwap<CR>
    nnoremap <silent> <Leader>esw :ISwapWith<CR>

" nvim-tree
    nnoremap <silent> <Leader>nc :NvimTreeClose<CR>
    nnoremap <silent> <Leader>nf :NvimTreeFindFile<CR>
    nnoremap <silent> <Leader>nn :NvimTreeToggle<CR>
    nnoremap <silent> <Leader>nr :NvimTreeRefresh<CR>
    nnoremap <silent> <Leader>nt :NvimTreeFocus<CR>

" jump between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" switch between buffers
nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" insert blank lines
nnoremap gO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap go  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" search for word (like grep -w)
nnoremap <Leader>s /\<\><left><left>

" reselect visual block after (un)indent
vnoremap < <gv
vnoremap > >gv

" select inserted/pasted text
nnoremap gV `[v`]

" make n/N always go in the same direction and center line
noremap <expr> <SID>(search-forward) 'Nn'[v:searchforward]
noremap <expr> <SID>(search-backward) 'nN'[v:searchforward]
nmap n <SID>(search-forward)
xmap n <SID>(search-forward)
nmap N <SID>(search-backward)
xmap N <SID>(search-backward)

" text objects
    xnoremap iu :lua require"treesitter-unit".select()<CR>
    xnoremap au :lua require"treesitter-unit".select(true)<CR>
    onoremap iu :<c-u>lua require"treesitter-unit".select()<CR>
    onoremap au :<c-u>lua require"treesitter-unit".select(true)<CR>

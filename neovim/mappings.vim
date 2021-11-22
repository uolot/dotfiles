" toggles
    nnoremap <Leader>xw :set wrap!<CR>
    " nnoremap <Leader>xW :call wilder#toggle()<CR>
    nnoremap <Leader>xcl :set background=light \| colorscheme github_light<CR>
    nnoremap <Leader>xcd :set background=dark \| colorscheme github_dimmed<CR>
    nnoremap <Leader>xa :ALEToggle<CR>

" lsp

    inoremap <silent> <C-k> <Cmd>lua vim.lsp.buf.signature_help()<CR>
    " nnoremap <silent> <Leader>ga :lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <Leader>ga :CodeActionMenu<CR>
    " vnoremap <silent> <Leader>ga :<C-u>lua vim.lsp.buf.range_code_action()<CR>
    vnoremap <silent> <Leader>ga :CodeActionMenu<CR>
    nnoremap <silent> <Leader>ge :vim.lsp.diagnostic.show_line_diagnostics()<CR>
    nnoremap <silent> <Leader>gd :lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <Leader>gD :lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <Leader>gf :Telescope lsp_references<CR>
    nnoremap <silent> <Leader>gF :lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <Leader>gh :lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <Leader>gi :lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <Leader>gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>
    nnoremap <silent> <Leader>gP <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
    nnoremap <silent> <Leader>gq <cmd>lua require('goto-preview').close_all_win()<CR>
    nnoremap <silent> <Leader>gR :lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <Leader>gs :lua vim.lsp.buf.signature_help()<CR>
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
    nnoremap <silent> <Leader>te :Telescope emoji<CR>
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

" colour
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
    " clear selection
    vnoremap <silent> <Leader>kk :<c-u>HSRmHighlight<CR>
    nnoremap <silent> <Leader>kk V:<c-u>HSRmHighlight<CR>
    " colour word/Word
    nnoremap <silent> <Leader>kw viw:<c-u>HSHighlight 1<CR>
    nnoremap <silent> <Leader>kW viW:<c-u>HSHighlight 1<CR>
    " clear all
    nnoremap <silent> <Leader>kx :<c-u>HSRmHighlight rm_all<CR>

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

" fast buffer switching
nnoremap <Backspace> <C-^>


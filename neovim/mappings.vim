" toggles
    " nnoremap <Leader>xa :ALEToggle<CR>
    " nnoremap <Leader>xbl :set background=light \| colorscheme github_light<CR>
    " nnoremap <Leader>xbd :set background=dark \| colorscheme github_dimmed<CR>
    nnoremap <Leader>xbl :set background=light<CR>
    nnoremap <Leader>xbd :set background=dark<CR>
    nnoremap <Leader>xd1 :lua vim.diagnostic.show()<CR>
    nnoremap <Leader>xd0 :lua vim.diagnostic.hide()<CR>
    nnoremap <Leader>xi :lua vim.lsp.buf.inlay_hint(0)<CR>
    nnoremap <Leader>xw :set wrap!<CR>
    nnoremap <Leader>xx :set relativenumber!<CR>

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
    " nnoremap <silent> <Leader>gf :Telescope lsp_references<CR>
    nnoremap <silent> <Leader>gf :lua require('telescope.builtin').lsp_references({fname_width=50})<CR>
    nnoremap <silent> <Leader>gh :lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <Leader>gI :lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <Leader>gi :Telescope lsp_incoming_calls<CR>
    nnoremap <silent> <Leader>go :Telescope lsp_outgoing_calls<CR>
    " nnoremap <silent> <Leader>gr :lua vim.lsp.buf.rename()<CR>
    nnoremap <Leader>gr :IncRename <C-r><C-w>
    nnoremap <silent> <Leader>gs :Telescope lsp_document_symbols<CR>
    nnoremap <silent> <Leader>gS :Telescope lsp_dynamic_workspace_symbols<CR>
    nnoremap <silent> <Leader>gt :lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <Leader>gu :lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <Leader>gwa :lua vim.lsp.buf.add_workspace_folder()<CR>
    nnoremap <silent> <Leader>gwr :lua vim.lsp.buf.remove_workspace_folder()<CR>
    nnoremap <silent> <Leader>gwl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
    nnoremap <silent> <Leader>gx :TroubleToggle document_diagnostics<CR>
    nnoremap <silent> <Leader>gX :TroubleToggle workspace_diagnostics<CR>

" telescope
    nnoremap <silent> <Leader>ff :Telescope find_files<CR>
    nnoremap <silent> <Leader>fgb :Telescope git_branches<CR>
    nnoremap <silent> <Leader>fgc :Telescope git_bcommits<CR>
    nnoremap <silent> <Leader>fgC :Telescope git_commits<CR>
    nnoremap <silent> <Leader>fgf :Telescope git_files<CR>
    nnoremap <silent> <Leader>fgs :Telescope git_status<CR>
    nnoremap <silent> <Leader>fgS :Telescope git_stash<CR>
    nnoremap <silent> <Leader>fo :Telescope oldfiles<CR>

" floaterm
    nnoremap <silent> <Leader>ft <Cmd>FloatermToggle<CR>
    nnoremap <silent> <Leader>fi <Cmd>FloatermNew --width=0.9 --height=0.9 --position=center<CR>
    " top
    nnoremap <silent> <Leader>fkk <Cmd>FloatermNew --width=0.99 --height=0.4 --position=top<CR>
    " bottom
    nnoremap <silent> <Leader>fll <Cmd>FloatermNew --width=0.4 --height=0.99 --position=right<CR>
    " left
    nnoremap <silent> <Leader>fhh <Cmd>FloatermNew --width=0.4 --height=0.99 --position=left<CR>
    " right
    nnoremap <silent> <Leader>fjj <Cmd>FloatermNew --width=0.99 --height=0.4 --position=bottom<CR>
    " top-left
    nnoremap <silent> <Leader>fhk <Cmd>FloatermNew --width=0.5 --height=0.5 --position=topleft<CR>
    nnoremap <silent> <Leader>fkh <Cmd>FloatermNew --width=0.5 --height=0.5 --position=topleft<CR>
    " bottom-left
    nnoremap <silent> <Leader>fhj <Cmd>FloatermNew --width=0.5 --height=0.5 --position=bottomleft<CR>
    nnoremap <silent> <Leader>fjh <Cmd>FloatermNew --width=0.5 --height=0.5 --position=bottomleft<CR>
    " top-right
    nnoremap <silent> <Leader>fkl <Cmd>FloatermNew --width=0.5 --height=0.5 --position=topright<CR>
    nnoremap <silent> <Leader>flk <Cmd>FloatermNew --width=0.5 --height=0.5 --position=topright<CR>
    " bottom- right
    nnoremap <silent> <Leader>fjl <Cmd>FloatermNew --width=0.5 --height=0.5 --position=bottomright<CR>
    nnoremap <silent> <Leader>flj <Cmd>FloatermNew --width=0.5 --height=0.5 --position=bottomright<CR>
    " vsplit
    nnoremap <silent> <Leader>fv <Cmd>FloatermNew --wintype=vsplit --position=right<CR>
    " split
    nnoremap <silent> <Leader>fs <Cmd>FloatermNew --wintype=split --position=bottom<CR>
    " terminal mappings
    tnoremap <silent> <C-S-t> <Cmd>FloatermToggle<CR>
    tnoremap <silent> <C-S-a> <C-\><C-n>
    " send current
    nnoremap <silent> <Leader>fs <Cmd>FloatermSend<CR>

" more telescope
    nnoremap <Leader>ta :Ag 
    nnoremap <silent> <Leader>tb :Telescope buffers<CR>
    nnoremap <silent> <Leader>td :TodoTelescope<CR>
    nnoremap <silent> <Leader>te :Telescope emoji<CR>
    nnoremap <silent> <Leader>tg :Telescope grep_string<CR>
    nnoremap <silent> <Leader>tG :Telescope live_grep<CR>
    nnoremap <silent> <Leader>tl :Telescope current_buffer_fuzzy_find<CR>
    nnoremap <silent> <Leader>tt :Telescope current_buffer_tags<CR>
    nnoremap <silent> <Leader>tT :Telescope tags<CR>

" nvim-tree
    nnoremap <silent> <Leader>nc :NvimTreeClose<CR>
    nnoremap <silent> <Leader>nf :NvimTreeFindFile<CR>
    nnoremap <silent> <Leader>nn :NvimTreeToggle<CR>
    nnoremap <silent> <Leader>nr :NvimTreeRefresh<CR>
    nnoremap <silent> <Leader>nt :NvimTreeFocus<CR>
" oil
    nnoremap <silent> <Leader>n- <Cmd>lua require("oil").open()<CR>

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
    nnoremap <Leader>j <cmd>Pounce<CR>
    " nnoremap <Leader>jn <cmd>PounceRepeat<CR>
    vnoremap <Leader>j <cmd>Pounce<CR>
    onoremap <Leader>j <cmd>Pounce<CR>
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

" winshift
    nnoremap <C-W><C-M> <Cmd>WinShift<CR>
    nnoremap <C-W>m <Cmd>WinShift<CR>
    nnoremap <C-W>x <Cmd>WinShift swap<CR>
    nnoremap <C-w>gh <Cmd>WinShift left<CR>
    nnoremap <C-w>gj <Cmd>WinShift down<CR>
    nnoremap <C-w>gk <Cmd>WinShift up<CR>
    nnoremap <C-w>gl <Cmd>WinShift right<CR>

" diffview
    nnoremap <Leader>df <Cmd>DiffviewFileHistory %<CR>
    nnoremap <Leader>dc <Cmd>DiffviewClose<CR>
    nnoremap <Leader>do <Cmd>DiffviewOpen<CR>

" overseer
    nnoremap <silent> <Leader>oo <Cmd>OverseerToggle<CR>
    nnoremap <Leader>oc :OverseerRunCmd 
    nnoremap <Leader>or :OverseerRun 

" rest-nvim
    nnoremap <Leader>rr <Plug>RestNvim
    nnoremap <Leader>rp <Plug>RestNvimPreview
    nnoremap <Leader>rl <Plug>RestNvimLast

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

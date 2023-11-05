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
    autocmd FileType markdown nmap <silent> <Leader>mp <Plug>MarkdownPreviewToggle
    autocmd FileType markdown nmap <silent> <Leader>mt :Toc<CR>
    autocmd FileType markdown nmap <silent> <Leader>mT :InsertToc<CR>
augroup end

local wk = require("which-key")

-- augroup markdown_mappings
--     autocmd FileType markdown nmap ]] <Plug>Markdown_MoveToNextSiblingHeader
--     autocmd FileType markdown nmap [[ <Plug>Markdown_MoveToPreviousSiblingHeader
--     autocmd FileType markdown nmap ]h <Plug>Markdown_MoveToNextHeader
--     autocmd FileType markdown nmap [h <Plug>Markdown_MoveToPreviousHeader
--     autocmd FileType markdown nmap ]u <Plug>Markdown_MoveToParentHeader
--     autocmd FileType markdown nmap [u <Plug>Markdown_MoveToParentHeader
--     autocmd FileType markdown nmap <silent> + :.HeaderIncrease<CR>
--     autocmd FileType markdown nmap <silent> - :.HeaderDecrease<CR>
--     autocmd FileType markdown nmap <silent> <Leader>mf :TableFormat<CR>
--     autocmd FileType markdown nmap <silent> <Leader>mp <Plug>MarkdownPreviewToggle
--     autocmd FileType markdown nmap <silent> <Leader>mt :Toc<CR>
--     autocmd FileType markdown nmap <silent> <Leader>mT :InsertToc<CR>
-- augroup end

wk.add({
    mode = "n",
    cond = function() return vim.bo.filetype == "markdown" end,
    -- { "]]",             "<Plug>Markdown_MoveToNextSiblingHeader",     desc = "Move to next sibling header" },
    -- { "[[",             "<Plug>Markdown_MoveToPreviousSiblingHeader", desc = "Move to previous sibling header" },
    -- { "<localleader>M", "<Cmd>Markview Toggle<CR>",      desc = "Toggle Markview globally" },
    -- { "<localleader>m", "<Cmd>Markview toggle<CR>",      desc = "Toggle Markview for buffer" },
    -- { "<localleader>s", "<Cmd>Markview splitToggle<CR>", desc = "Toggle Markview split" },
    -- { "<localleader>x", "<Cmd>Checkbox change 1 0<CR>",  desc = "Toggle checkbox" },
    -- { "<localleader>a", "<Cmd>Heading decrease<CR>",     desc = "Increase heading level" },
    -- { "<localleader>d", "<Cmd>Heading increase<CR>",     desc = "Decrease heading level" },
})

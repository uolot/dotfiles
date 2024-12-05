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
    { "]]", "<Plug>Markdown_MoveToNextSiblingHeader",     desc = "Move to next sibling header" },
    { "[[", "<Plug>Markdown_MoveToPreviousSiblingHeader", desc = "Move to previous sibling header" },
    { "]h", "<Plug>Markdown_MoveToNextHeader",            desc = "Move to next header" },
    { "[h", "<Plug>Markdown_MoveToPreviousHeader",        desc = "Move to previous header" },
    { "]u", "<Plug>Markdown_MoveToParentHeader",          desc = "Move to parent header" },
    { "[u", "<Plug>Markdown_MoveToParentHeader",          desc = "Move to parent header" },
    {
        silent = true,
        { "<localleader>-",  group = "Markdown" },
        { "<localleader>-a", ":.HeaderIncrease<CR>",        desc = "Increase header level" },
        { "<localleader>-d", ":.HeaderDecrease<CR>",        desc = "Decrease header level" },
        { "<localleader>-f", ":TableFormat<CR>",            desc = "Format table" },
        { "<localleader>-p", "<Plug>MarkdownPreviewToggle", desc = "Toggle markdown preview" },
        { "<localleader>-t", ":Toc<CR>",                    desc = "Generate table of contents" },
        { "<localleader>-T", ":InsertToc<CR>",              desc = "Insert table of contents" },
    },
})

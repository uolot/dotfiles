vim.cmd [[highlight IndentBlanklineIndent1 guifg=#444444 gui=nocombine]]
-- -- vim.cmd [[highlight IndentBlanklineContextChar guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#909090 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=#909090 gui=underline]]

local opts = {
    use_treesitter = true,
    space_char_blankline = " ",
    -- char_list = {'│', '¦'},
    char = '│',
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = false,
    char_highlight_list = {
        "IndentBlanklineIndent1",
    },
    buftype_exclude = { "terminal", "nofile" },
    -- filetype_exclude = {},
}

return { opts = opts }

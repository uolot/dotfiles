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

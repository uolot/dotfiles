-- FIXME: https://github.com/lukas-reineke/indent-blankline.nvim/wiki/Migrate-to-version-3

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#444444 gui=nocombine]]
-- -- vim.cmd [[highlight IndentBlanklineContextChar guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#909090 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=#909090 gui=underline]]

local opts = {
    indent = {
        -- char = '│',
        char = '▏',
    },
    scope = {
        enabled = true,
        show_start = true,
    },
    -- char_highlight_list = { "IndentBlanklineIndent1" },
    exclude = {
        filetypes = {},
        buftypes = { "terminal", "nofile" },
    },
}

return { opts = opts }

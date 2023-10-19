-- Configured in bamboo theme:
-- vim.cmd [[highlight IblIndent guifg=#ff0000 gui=nocombine]]
-- vim.cmd [[highlight IblWhitespace guifg=#00ff00 gui=nocombine]]
-- vim.cmd [[highlight IblScope guifg=#0000ff gui=nocombine]]

local opts = {
    indent = {
        -- char = '│',
        char = '▏',
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        -- char = '▎',
        include = {
            -- check the current node:
            -- print(vim.treesitter.get_node():type())
            -- see also:
            -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/632
            node_type = {
                -- { ['*'] = { '*' } },
                javascript = {
                    "named_imports",
                    "parenthesized_expression",
                    "object",
                },
                typescript = {
                    "named_imports",
                    "parenthesized_expression",
                    "object",
                },
            },
        },
    },
    exclude = {
        filetypes = {},
        buftypes = { "terminal", "nofile" },
    },
}

return { opts = opts }

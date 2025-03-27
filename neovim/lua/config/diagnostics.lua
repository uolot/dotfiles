-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
vim.diagnostic.config({
    virtual_text = {
        current_line = true,
        source = "if_many",
        prefix = '●',
        spacing = 1,
    },
    virtual_lines = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        header = '',
        source = 'if_many',
    },
    signs = true,
})

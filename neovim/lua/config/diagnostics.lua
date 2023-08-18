-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
vim.diagnostic.config({
    -- virtual_text = false,
    virtual_text = {
        source = false,
        prefix = '●',
        spacing = 1,
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = true,
        -- source = false,
    },
    signs = true,
    -- virtual_lines = false,
})

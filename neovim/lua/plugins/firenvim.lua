local function build()
    -- require('lazy').load({ plugins = 'firenvim', wait = true })
    vim.fn['firenvim#install'](0)
end

local function config()
    vim.g.firenvim_config = {
        globalSettings = {
            alt = 'all',
        },
        localSettings = {
            ['.*'] = {
                cmdline = 'neovim',
                content = 'text',
                priority = 0,
                selector = 'textarea',
                takeover = 'never',
            },
        },
    }
    vim.opt.background = 'light'
    vim.opt.guifont = 'BlexMono Ner Font Mono:h12'

    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        nested = true,
        command = "write"
    })
end

return {
    build = build,
    config = config,
}

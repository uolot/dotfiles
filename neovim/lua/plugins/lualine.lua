local opts = {
    options = {
        -- theme = 'github',
        -- theme = 'auto',
        -- theme = 'nordic',
        -- theme = 'kanagawa',
        globalstatus = false,
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
            {
                'fileformat',
                icons_enabled = true,
                symbols = {
                    unix = '',
                    dos = ' CRLF ',
                    mac = ' CR ',
                },
            },
        },
        lualine_c = {
            'searchcount',
            { 'diagnostics', sections = { "error", "warn" } },
            {
                'lsp_progress',
                display_components = {
                    'lsp_client_name',
                    {
                        'percentage',
                    },
                },
            },
        },
        -- right
        lualine_x = {
            -- 'branch',
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = { 'location', 'progress' },
    },
    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
        },
        lualine_c = {
            { 'diagnostics', sections = { "error", "warn" } },
        },
        -- right
        lualine_x = {
        },
        lualine_y = {
        },
        lualine_z = {},
    }
}

return { opts = opts }

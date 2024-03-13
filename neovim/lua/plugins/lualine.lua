local opts = {
    options = {
        globalstatus = false,
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = {
            {
                'filename',
                path = 1,
                shorting_target = 40,
            },
            {
                'fileformat',
                icons_enabled = true,
                symbols = { unix = '', dos = ' CRLF ', mac = ' CR ', },
            },
        },
        lualine_c = {
            {
                'diagnostics',
                sections = { "error", "warn" },
            },
            'diff',
            'branch',
        },
        -- right
        lualine_x = {
            {
                'lsp_progress',
                display_components = {
                    'lsp_client_name',
                    { 'percentage', },
                },
            },
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = {
            'searchcount',
            'location',
            'progress',
        },
    },
    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
        },
        lualine_c = {
            {
                'diagnostics',
                sections = { "error", "warn" },
            },
            'diff',
        },
        -- right
        lualine_x = {
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = {},
    }
}

return { opts = opts }

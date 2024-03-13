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
                'lsp_progress',
                display_components = {
                    'lsp_client_name',
                    { 'percentage', },
                },
            },
        },
        -- right
        lualine_x = {
        },
        lualine_y = {
            'location',
            'progress',
        },
        lualine_z = {
            'filetype'
        },
    },
    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
        },
        lualine_c = {},
        -- right
        lualine_x = {
        },
        lualine_y = {
        },
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
        },
        lualine_b = {
            { 'tabs', mode = 2 },
        },
        lualine_c = {},
        lualine_x = {
        },
        lualine_y = {
            { 'buffers', mode = 4 },
        },
        lualine_z = {
        }
    },
    winbar = {
        lualine_a = {
            'filename',
        },
        lualine_b = {
            {
                'diagnostics',
                sections = { "error", "warn" },
            },
        },
        lualine_c = {
        },
        lualine_x = {
            'branch',
        },
        lualine_y = {
            'diff',
        },
        lualine_z = {
        }
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            'filename',
            {
                'diagnostics',
                sections = { "error", "warn" },
                colored = false,
            },
        },
        lualine_x = {
        },
        lualine_y = {
            { 'diff', colored = false },
        },
        lualine_z = {}
    },
}

return { opts = opts }

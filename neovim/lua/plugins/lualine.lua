local opts = {
    options = {
        globalstatus = false,
    },

    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = {
            {
                'fileformat',
                icons_enabled = true,
                symbols = { unix = '', dos = ' CRLF ', mac = ' CR ', },
            },
            'filename',
            'diagnostics',
        },
        lualine_c = {
            'diff',
        },
        -- right
        lualine_x = {
        },
        lualine_y = {
            'progress',
            'location',
        },
        lualine_z = {
            'filetype'
        },
    },

    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            'filename',
            { 'diagnostics', colored = false },
        },
        lualine_c = {
            { 'diff', colored = false },
        },
        -- right
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },

    winbar = {
        lualine_a = {
        },
        lualine_b = {
        },
        lualine_c = {
        },
        lualine_x = {
        },
        lualine_y = {
        },
        lualine_z = {
        }
    },

    inactive_winbar = {
        lualine_a = {
        },
        lualine_b = {
        },
        lualine_c = {
        },
        lualine_x = {
        },
        lualine_y = {
        },
        lualine_z = {}
    },

    tabline = {
        lualine_a = {
            {
                'tabs',
                mode = 0,
                -- use_mode_color = true,
            },
        },
        lualine_b = {
        },
        lualine_c = {
            -- {
            --     'windows',
            --     mode = 2,
            -- },
            {
                'filename',
                path = 1,
                shorting_target = 0,
            },
            -- 'diagnostics',
        },
        lualine_x = {
            {
                'lsp_progress',
                display_components = {
                    'lsp_client_name',
                    'spinner',
                    'percentage',
                    -- { 'title', 'percentage' },
                },
            },
            {
                'lsp_status',
                icon = '', -- f013
                symbols = {
                    -- Standard unicode symbols to cycle through for LSP progress:
                    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                    -- Standard unicode symbol for when LSP is done:
                    done = '✓',
                    -- Delimiter inserted between LSP names:
                    separator = ' ',
                },
                -- List of LSP names to ignore (e.g., `null-ls`):
                ignore_lsp = {},
            },
        },
        lualine_y = {
            -- 'diff',
            -- {
            --     'filename',
            --     path = 1,
            --     shorting_target = 0,
            -- },
        },
        lualine_z = {
            'branch',
        }
    },
}

return { opts = opts }

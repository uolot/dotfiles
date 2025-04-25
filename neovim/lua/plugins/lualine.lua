local left = ''
local right = ''
local separators = { left = left, right = right }

local opts = {
    options = {
        globalstatus = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },

    extensions = { 'aerial', 'quickfix' },

    sections = {
        -- left
        lualine_a = {
            { 'mode', separator = separators },
        },
        lualine_b = {
            { 'diff', icon = '', padding = 2 },
            { 'diagnostics', padding = 2 },
            { 'searchcount', icon = '', padding = 2 },
        },
        lualine_c = {
            { '%=', separator = '' },
            {
                'fileformat',
                icons_enabled = true,
                symbols = { unix = '', dos = ' CRLF ', mac = ' CR ', },
            },
            'filename',
        },
        -- right
        lualine_x = {
        },
        lualine_y = {
            -- 'progress',
            { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
            { 'filetype', separator = separators }
        },
    },

    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            { 'diff',        colored = false },
            { 'diagnostics', colored = false },
        },
        lualine_c = {
            { '%=', separator = '' },
            'filename',
        },
        -- right
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },

    tabline = {
        lualine_a = {
            {
                'tabs',
                mode = 2,
                separator = separators,
                use_mode_colors = true,
                show_modified_status = false,
            },
        },
        lualine_b = {
            {
                'filename',
                path = 1,
                shorting_target = 0,
            },
        },
        lualine_c = {
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
            { 'branch', separator = separators },
        },
        lualine_z = {}
    },
}

return { opts = opts }

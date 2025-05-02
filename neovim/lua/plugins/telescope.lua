local dependencies = {
    { "nvim-lua/plenary.nvim",                   lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
}

local function config()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local themes = require('telescope.themes')

    telescope.setup {
        defaults = {
            -- defaults = themes.get_ivy {
            -- defaults = themes.get_dropdown {
            layout_strategy = 'center',
            layout_config = {
                prompt_position = 'top',
                -- mirror = true,
            },
            dynamic_preview_title = true,
            sorting_strategy = 'ascending',
            -- path_display = { shorten = 3 },
            -- wrap_results = true,
            mappings = {
                i = {
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    ["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
                    ["<C-d>"] = actions.results_scrolling_down,
                    ["<C-u>"] = actions.results_scrolling_up,
                    ["<C-f>"] = actions.preview_scrolling_down,
                    ["<C-b>"] = actions.preview_scrolling_up,
                },
            },
            file_ignore_patterns = { "tags*" },
            pickers = {
                find_files = {
                    -- theme = "ivy",
                },
                live_grep = {
                    only_sort_text = true,
                },
                lsp_references = {
                    -- fname_width = 50,
                    include_current_line = true,
                    include_declaration = true,
                },
                tags = {
                    max_results = 1000,
                },
            },
        },
        extensions = {
            ['ui-select'] = {
                themes.get_dropdown {}
            },
        },
    }

    telescope.load_extension('ui-select')
end

return { config = config, dependencies = dependencies }

local dependencies = {
    "nvim-lua/plenary.nvim",
    "kelly-lin/telescope-ag",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    'piersolenski/telescope-import.nvim',
    "debugloop/telescope-undo.nvim",
}

local function config()
    local actions = require('telescope.actions')
    require('telescope').setup {
        defaults = {
            -- defaults = require('telescope.themes').get_ivy {
            -- defaults = require('telescope.themes').get_dropdown {
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
                require('telescope.themes').get_dropdown {}
            },
            undo = {
                side_by_side = true,
                layout_strategy = "vertical",
                layout_config = {
                    preview_height = 0.7,
                },
            },
        },
    }

    require('telescope').load_extension('ag')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("import")
    require("telescope").load_extension("undo")
end

return { config = config, dependencies = dependencies }

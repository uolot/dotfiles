local dependencies = {
    { "nvim-lua/plenary.nvim",                        lazy = true },
    { "kelly-lin/telescope-ag",                       lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim",      lazy = true },
    { "nvim-telescope/telescope-live-grep-args.nvim", lazy = true },
    { "debugloop/telescope-undo.nvim",                lazy = true },
}

local function config()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local themes = require('telescope.themes')

    local live_grep_args_actions = require('telescope-live-grep-args.actions')
    local telescope_undo_actions = require('telescope-undo.actions')

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
            undo = {
                side_by_side = true,
                layout_strategy = "vertical",
                layout_config = {
                    preview_height = 0.7,
                },
                mappings = {
                    i = {
                        ["<cr>"] = telescope_undo_actions.restore,
                        ["<C-cr>"] = telescope_undo_actions.yank_additions,
                        ["<S-cr>"] = telescope_undo_actions.yank_deletions,
                    },
                    n = {},
                },
            },
            live_grep_args = {
                auto_quoting = true,
                mappings = {
                    i = {
                        ["<C-k>"] = live_grep_args_actions.quote_prompt(),
                        ["<C-i>"] = live_grep_args_actions.quote_prompt({ postfix = " --iglob " }),
                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-r>"] = actions.to_fuzzy_refine,
                    },
                },
            },
        },
    }

    telescope.load_extension('ag')
    telescope.load_extension('ui-select')
    telescope.load_extension("live_grep_args")
    telescope.load_extension("undo")
end

return { config = config, dependencies = dependencies }

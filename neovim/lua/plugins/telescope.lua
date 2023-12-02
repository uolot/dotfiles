local dependencies = {
    { "nvim-lua/plenary.nvim",                        lazy = true },
    { "kelly-lin/telescope-ag",                       lazy = true },
    { "nvim-telescope/telescope-fzf-native.nvim",     lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim",      lazy = true },
    { "nvim-telescope/telescope-live-grep-args.nvim", lazy = true },
    { 'piersolenski/telescope-import.nvim',           lazy = true },
    { "debugloop/telescope-undo.nvim",                lazy = true },
    { "nvim-telescope/telescope-frecency.nvim",       lazy = true },
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
                mappings = {
                    i = {
                        ["<cr>"] = require("telescope-undo.actions").restore,
                        ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                    },
                    n = {},
                },
            },
            frecency = {
                ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*", "*venv/*" },
                db_safe_mode = true,
                -- NOTE: run :FrecencyValidate to remove deleted files from frecency database
                auto_validate = false,
                workspaces = {
                    ["monorepo"] = os.getenv("HOME") .. "/Dev/cd-monorepo",
                    ["estore"] = os.getenv("HOME") .. "/Dev/cd-monorepo/apps/estore-integrator",
                    ["brandbank"] = os.getenv("HOME") .. "/Dev/cd-monorepo/apps/brandbank-integrator",
                    ["salsify"] = os.getenv("HOME") .. "/Dev/cd-monorepo/apps/salsify-integrator",
                    ["content-api"] = os.getenv("HOME") .. "/Dev/cd-monorepo/apps/content-api",
                    ["dotfiles"] = os.getenv("HOME") .. "/.dotfiles",
                    ["neovim"] = os.getenv("HOME") .. "/.dotfiles/neovim",
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
    require("telescope").load_extension "frecency"
end

return { config = config, dependencies = dependencies }

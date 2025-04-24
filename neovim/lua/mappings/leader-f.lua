local wk = require("which-key")
local telescope_builtin = require("telescope.builtin")
local mini_files = require("mini.files")

local function mini_files_current()
    local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
    if not mini_files.close() then mini_files.open(path, false) end
end

local function mini_files_toggle()
    if not mini_files.close() then mini_files.open() end
end

local function telescope_search_git_root()
    local git_root = Snacks.git.get_root()
    telescope_builtin.find_files({ cwd = git_root })
end

local function find_all_files()
    Snacks.picker.files({ hidden = true, ignored = true })
end

local function find_hidden_files()
    Snacks.picker.files({ hidden = true, ignored = false })
end

local function snipe()
    require("snipe").open_buffer_menu()
end

wk.add({
    mode = "n",
    { "<Leader>f",  group = "+files" },
    -- Telescope
    {
        "<Leader>ff",
        function()
            Snacks.picker.files({ formatters = { file = { truncate = 100 } } })
        end,
        desc = "Find files"
    },
    { "<Leader>fa", find_all_files,       desc = "Find all files" },
    { "<Leader>fe", Snacks.explorer.open, desc = "Toggle explorer" },
    {
        "<Leader>fg",
        function()
            Snacks.picker.git_status({ formatters = { file = { truncate = 100 } } })
        end,
        desc = "Find modified git files",
    },
    { "<Leader>fh", find_hidden_files,       desc = "Find hidden files" },
    { "<Leader>fo", Snacks.picker.recent,    desc = "Find recent files" },
    { "<Leader>fp", Snacks.picker.projects,  desc = "Find projects" },
    { "<Leader>fr", Snacks.picker.git_files, desc = "Find files in git root" },
    { "<Leader>fs", snipe,                   desc = "Open Snipe buffer menu" },
    { "<Leader>fz", Snacks.picker.zoxide,    desc = 'Zoxide' },
    -- Mini files
    { "<Leader>fc", mini_files_current,      desc = "mini.files: Show current file" },
    { "<Leader>fm", mini_files_toggle,       desc = "mini.files: Open", },
})

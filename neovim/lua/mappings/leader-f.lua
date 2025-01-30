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

wk.add({
    mode = "n",
    { "<Leader>f",  group = "+files" },
    -- Telescope
    { "<Leader>ff", Snacks.picker.files,      desc = "Find files" },
    { "<Leader>fg", Snacks.picker.git_status, desc = "Find modified git files" },
    { "<Leader>fh", find_hidden_files,        desc = "Find hidden files" },
    { "<Leader>fa", find_all_files,           desc = "Find all files" },
    { "<Leader>fo", Snacks.picker.recent,     desc = "Find recent files" },
    { "<Leader>fp", Snacks.picker.git_files,  desc = "Find files in git root" },
    -- Mini files
    { "<Leader>fc", mini_files_current,       desc = "mini.files: Show current file" },
    { "<Leader>fm", mini_files_toggle,        desc = "mini.files: Open", },
})

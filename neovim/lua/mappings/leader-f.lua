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
    local fname = vim.api.nvim_buf_get_name(0)
    -- TODO: Use require('snacks').git.get_root() instead?
    local git_root = require("lspconfig.util").find_git_ancestor(fname)
    telescope_builtin.find_files({ cwd = git_root })
end

local function telescope_find_all()
    telescope_builtin.find_files({ hidden = true, no_ignore = true })
end

local function telescope_find_hidden()
    telescope_builtin.find_files({ hidden = true, no_ignore = false })
end

wk.add({
    mode = "n",
    { "<Leader>f",  group = "+files" },
    -- Telescope
    { "<Leader>ff", telescope_builtin.find_files, desc = "Find files" },
    { "<Leader>fg", telescope_builtin.git_status, desc = "Find modified git files" },
    { "<Leader>fh", telescope_find_hidden,        desc = "Find hidden files" },
    { "<Leader>fa", telescope_find_all,           desc = "Find all files" },
    { "<Leader>fo", telescope_builtin.oldfiles,   desc = "Find recent files" },
    { "<Leader>fp", telescope_search_git_root,    desc = "Find files in git root" },
    -- Mini files
    { "<Leader>fc", mini_files_current,           desc = "mini.files: Show current file" },
    { "<Leader>fm", mini_files_toggle,            desc = "mini.files: Open", },
})

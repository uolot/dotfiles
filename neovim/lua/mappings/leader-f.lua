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

wk.add({
    mode = "n",
    { "<Leader>f",   group = "Find" },
    -- Telescope
    { "<Leader>ff",  telescope_builtin.find_files,                desc = "Find files" },
    { "<Leader>fg",  telescope_builtin.git_status,                desc = "Find modified git files" },
    { "<Leader>fh",  "<Cmd>Telescope find_files hidden=true<CR>", desc = "Find hidden files" },
    { "<Leader>fo",  telescope_builtin.oldfiles,                  desc = "Open recent files" },
    { "<Leader>fp",  telescope_search_git_root,                   desc = "Find files in git root" },
    -- Mini files
    { "<Leader>fm",  group = "Mini files" },
    { "<Leader>fmc", mini_files_current,                          desc = "Current file" },
    { "<Leader>fmo", mini_files_toggle,                           desc = "Open", },
})

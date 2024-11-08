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
    { "<Leader>f",  group = "+files" },
    -- Telescope
    { "<Leader>ff", telescope_builtin.find_files,                desc = "Open files" },
    { "<Leader>fg", telescope_builtin.git_status,                desc = "Open modified git files" },
    { "<Leader>fh", "<Cmd>Telescope find_files hidden=true<CR>", desc = "Open hidden files" },
    { "<Leader>fo", telescope_builtin.oldfiles,                  desc = "Open recent files" },
    { "<Leader>fp", telescope_search_git_root,                   desc = "Open files in git root" },
    -- Mini files
    { "<Leader>fc", mini_files_current,                          desc = "mini.files: Show current file" },
    { "<Leader>f",  mini_files_toggle,                           desc = "mini.files: Open", },
})

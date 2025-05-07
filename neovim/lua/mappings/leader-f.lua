local wk = require("which-key")
local mini_files = require("mini.files")

local function mini_files_current()
    local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
    if not mini_files.close() then mini_files.open(path, false) end
end

local function mini_files_toggle()
    if not mini_files.close() then mini_files.open() end
end

local function find_files()
    Snacks.picker.files({ formatters = { file = { truncate = 100 } } })
end

local function find_all_files()
    Snacks.picker.files({ hidden = true, ignored = true })
end

local function find_recent_files()
    Snacks.picker.recent({
        filter = {
            paths = {
                [Snacks.git.get_root()] = true,
            }
        }
    })
end

local function find_hidden_files()
    Snacks.picker.files({ hidden = true, ignored = false })
end

local function find_git_modified_files()
    Snacks.picker.git_status({
        formatters = { file = { truncate = 100 } },
        win = {
            input = {
                keys = {
                    ["<Space>"] = { "git_stage", mode = { "n", "i" } },
                    ["<Tab>"] = { "select_and_next", mode = { "n", "i" } },
                }
            }
        }
    })
end

local function snipe()
    require("snipe").open_buffer_menu()
end

wk.add({
    mode = "n",
    { "<Leader>f",  group = "+files" },
    { "<Leader>fe", Snacks.explorer.open, desc = "Toggle explorer" },
    {
        "<Leader>ff",
    { "<Leader>ff", find_files,              desc = "Find files" },
    { "<Leader>fg", find_git_modified_files, desc = "Find modified git files" },
    { "<Leader>fG", Snacks.picker.git_files, desc = "Find files in git root" },
    { "<Leader>fh", find_hidden_files,       desc = "Find hidden files" },
    { "<Leader>fi", find_all_files,          desc = "Find all files" },
    { "<Leader>fo", find_recent_files,       desc = "Find recent files" },
    { "<Leader>fp", Snacks.picker.projects,  desc = "Find projects" },
    { "<Leader>fs", snipe,                   desc = "Open Snipe buffer menu" },
    { "<Leader>fz", Snacks.picker.zoxide,    desc = 'Zoxide' },
    -- Mini files
    { "<Leader>fc", mini_files_current,      desc = "mini.files: Show current file" },
    { "<Leader>fm", mini_files_toggle,       desc = "mini.files: Open", },
})

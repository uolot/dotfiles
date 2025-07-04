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

local function find_files_smart()
    Snacks.picker.smart({ formatters = { file = { truncate = 100 } } })
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

local function open_buffer_menu()
    local buffinfo = vim.fn.getbufinfo()
    local listed_buffers = vim.tbl_filter(function(b)
        return b.listed == 1 and b.name ~= nil and b.name ~= ""
    end, buffinfo)

    local hidden = vim.tbl_filter(function(b)
        return b.hidden == 1
    end, listed_buffers) or {}
    local visible = vim.tbl_filter(function(b)
        return b.hidden == 0
    end, listed_buffers) or {}

    local buffers = vim.tbl_extend("keep", hidden, visible, listed_buffers)

    -- remove duplicate buffers
    local unique_buffers = {}
    local seen = {}
    for _, buf in ipairs(buffers) do
        if not seen[buf.bufnr] then
            seen[buf.bufnr] = true
            table.insert(unique_buffers, buf)
        end
    end

    require('fastaction').select(unique_buffers, {
        prompt = "Select buffer",
        format_item =
            function(item)
                local relative_to_cwd = vim.fn.fnamemodify(item.name, ":.")
                return relative_to_cwd
            end,
        kind = "buffer",
    }
    , function(choice)
        vim.api.nvim_set_current_buf(choice.bufnr)
    end)
end

wk.add({
    mode = "n",
    { "<Leader>f",  group = "+files" },
    { "<Leader>fb", open_buffer_menu,        desc = "Buffer menu" },
    { "<Leader>fe", Snacks.explorer.open,    desc = "Toggle explorer" },
    { "<Leader>ff", find_files,              desc = "Find files" },
    { "<Leader>fg", find_git_modified_files, desc = "Find modified git files" },
    { "<Leader>fG", Snacks.picker.git_files, desc = "Find files in git root" },
    { "<Leader>fh", find_hidden_files,       desc = "Find hidden files" },
    { "<Leader>fi", find_all_files,          desc = "Find all files" },
    { "<Leader>fo", find_recent_files,       desc = "Find recent files" },
    { "<Leader>fp", Snacks.picker.projects,  desc = "Find projects" },
    { "<Leader>fs", find_files_smart,        desc = "Smart open" },
    { "<Leader>fz", Snacks.picker.zoxide,    desc = 'Zoxide' },
    -- Mini files
    { "<Leader>fc", mini_files_current,      desc = "mini.files: Show current file" },
    { "<Leader>fm", mini_files_toggle,       desc = "mini.files: Open", },
})

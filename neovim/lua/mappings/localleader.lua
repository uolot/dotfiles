local wk = require("which-key")

local function delete_current_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    Snacks.bufdelete(bufnr)
end

local function rename_current_tab()
    vim.ui.input(
        { prompt = "Tab name: " },
        function(name)
            if name then
                vim.cmd('LualineRenameTab ' .. name)
            end
        end
    )
end

local function rename_current_buffer_file()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == "" or vim.bo.buftype ~= "" then
        vim.notify("No file to rename", vim.log.levels.WARN)
        return
    end
    local dir = vim.fn.fnamemodify(current_file, ":h")
    local current_name = vim.fn.fnamemodify(current_file, ":t")
    vim.ui.input(
        {
            prompt = "New filename: ",
            default = current_name
        },
        function(new_name)
            if not new_name or new_name == "" or new_name == current_name then
                return
            end
            local new_file = dir .. "/" .. new_name
            if vim.fn.filereadable(new_file) == 1 then
                vim.notify("File already exists: " .. new_file, vim.log.levels.ERROR)
                return
            end
            vim.cmd("saveas " .. vim.fn.fnameescape(new_file))
            if vim.fn.delete(current_file) == 0 then
                Snacks.rename.on_rename_file(current_file, new_file)
                vim.notify("Renamed: " .. current_name .. " → " .. new_name, vim.log.levels.INFO)
            else
                vim.notify("Failed to delete old file: " .. current_file, vim.log.levels.WARN)
            end
        end
    )
end

wk.add({
    mode = "n",
    -- buffers
    { "<localleader>n", "<Cmd>enew<CR>",    desc = "Open new buffer" },
    {
        { "<localleader>b",  group = "+bufs" },
        { "<localleader>bn", "<Cmd>enew<CR>",               desc = "Open new buffer" },
        { "<localleader>bd", delete_current_buffer,         desc = "Delete current buffer" },
        { "<localleader>bD", "<Cmd>!rm %<CR>",              desc = "Delete current file" },
        { "<localleader>bq", "<Cmd>bd!<CR>",                desc = "Force close buffer" },
        { "<localleader>br", rename_current_buffer_file,    desc = "Rename current buffer file" },
        { "<localleader>by", ":let @+=expand('%:~:.')<CR>", desc = "Yank relative path" },
        { "<localleader>bY", ":let @+=expand('%:p:~')<CR>", desc = "Yank absolute path" },
    },
    -- tabs
    {
        { "<localleader>t",  group = "+tabs" },
        { "<localleader>tc", "<Cmd>tabnew<CR>",           desc = "Open new tab" },
        { "<localleader>td", "<Cmd>tabclose<CR>",         desc = "Close tab" },
        { "<localleader>tn", "<Cmd>tabnew<CR>",           desc = "Open new tab" },
        { "<localleader>tr", rename_current_tab,          desc = "Rename tab" },
        { "<localleader>tR", "<Cmd>LualineRenameTab<CR>", desc = "Reset tab name" },
        { "<localleader>tx", "<Cmd>tabclose<CR>",         desc = "Close tab" },
    },
    -- buf nav
    { "<localleader>k", "<Cmd>bnext<CR>",   desc = "Next buffer" },
    { "<localleader>j", "<Cmd>bprev<CR>",   desc = "Previous buffer" },
    -- tab nav
    { "<localleader>l", "<Cmd>tabnext<CR>", desc = "Next tab" },
    { "<localleader>h", "<Cmd>tabprev<CR>", desc = "Previous tab" },
    -- quickfix & loclist
    {
        { "<localleader>q", function() require('quicker').toggle() end,                   desc = "Toggle quickfix" },
        { "<localleader>Q", function() require('quicker').toggle({ loclist = true }) end, desc = "Toggle loclist" },
    },
    -- system clipboard
    { "<localleader>p",     '"+p', desc = "Paste from system clipboard below" },
    { "<localleader><S-p>", '"+P', desc = "Paste from system clipboard above" },
    {
        mode = { "n", "v" },
        { "<localleader>y", '"+y', desc = "Yank to system clipboard" },
    },
})

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

wk.add({
    mode = "n",
    -- buffers
    { "<localleader>n", "<Cmd>enew<CR>",    desc = "Open new buffer" },
    {
        { "<localleader>b",  group = "+bufs" },
        { "<localleader>bn", "<Cmd>enew<CR>",       desc = "Open new buffer" },
        { "<localleader>bd", delete_current_buffer, desc = "Delete current buffer" },
        { "<localleader>bD", "<Cmd>!rm %<CR>",      desc = "Delete current file" },
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

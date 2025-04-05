local wk = require("which-key")

local function delete_current_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    Snacks.bufdelete(bufnr)
end

wk.add({
    mode = "n",
    -- buffers
    { "<localleader>n", "<Cmd>enew<CR>",    desc = "Open new buffer" },
    {
        { "<localleader>b",  group = "+bufs" },
        { "<localleader>bn", "<Cmd>enew<CR>",       desc = "Open new buffer" },
        { "<localleader>bd", delete_current_buffer, desc = "Delete current buffer" },
    },
    -- tabs
    {
        { "<localleader>t",  group = "+tabs" },
        { "<localleader>tn", "<Cmd>tabnew<CR>",   desc = "Open new tab" },
        { "<localleader>tc", "<Cmd>tabclose<CR>", desc = "Close current tab" },
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

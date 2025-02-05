local wk = require("which-key")
local wk_extras = require("which-key.extras")

local function delete_current_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    Snacks.bufdelete(bufnr)
end

wk.add({
    mode = "n",
    { "<localleader>bd", delete_current_buffer, desc = "Delete current buffer" },
    { "<localleader>tn", "<Cmd>tabnew<CR>",     desc = "Open new tab" },
    { "<localleader>tc", "<Cmd>tabclose<CR>",   desc = "Close current tab" },
    { "<localleader>n",  "<Cmd>enew<CR>",       desc = "Open new file" },
    { "<localleader>k",  "<Cmd>bnext<CR>",      desc = "Next buffer" },
    { "<localleader>j",  "<Cmd>bprev<CR>",      desc = "Previous buffer" },
    { "<localleader>l",  "<Cmd>tabnext<CR>",    desc = "Next tab" },
    { "<localleader>h",  "<Cmd>tabprev<CR>",    desc = "Previous tab" },
    { "<localleader>qq", "<Cmd>cclose<CR>",     desc = "Close quickfix window" },
    { "<localleader>qo", "<Cmd>copen<CR>",      desc = "Open quickfix window" },
})

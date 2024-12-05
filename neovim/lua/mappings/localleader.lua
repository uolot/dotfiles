local wk = require("which-key")
local wk_extras = require("which-key.extras")

local function delete_current_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    Snacks.bufdelete(bufnr)
end

wk.add({
    mode = "n",
    { "<localleader>bd", delete_current_buffer, desc = "Delete current buffer" },
})

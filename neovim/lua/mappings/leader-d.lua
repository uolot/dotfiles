local wk = require("which-key")

wk.add({
    mode = "n",
    { "<Leader>d",  group = "Diffview" },
    -- Diffview
    { "<Leader>dc", "<Cmd>DiffviewClose<CR>",         desc = "Diffview: Close" },
    { "<Leader>dh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview: File history" },
    { "<Leader>do", "<Cmd>DiffviewOpen<CR>",          desc = "Diffview: Open" },
})

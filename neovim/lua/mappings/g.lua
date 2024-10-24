local wk = require("which-key")

wk.add({
    mode = "n",
    silent = true,
    { "gB", "<Cmd>bp<CR>",                                   desc = "Previous buffer" },
    { "gb", "<Cmd>bn<CR>",                                   desc = "Next buffer" },
    { "gO", ":<C-u>put! =repeat(nr2char(10), v:count1)<CR>", desc = "Insert blank lines above" },
    { "go", ":<C-u>put =repeat(nr2char(10), v:count1)<CR>",  desc = "Insert blank lines below" },
    { "gV", "`[v`]",                                         desc = "Select inserted/pasted text" },
})

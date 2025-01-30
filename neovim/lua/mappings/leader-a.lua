local wk = require("which-key")

wk.add({
    mode = "n",
    { "<Leader>a",  group = "+aerial" },
    { "<Leader>aa", '<Cmd>AerialToggle<CR>',       desc = "Toggle Aerial" },
    { "<Leader>af", '<Cmd>AerialToggle float<CR>', desc = 'Toggle Aerial float' },
    { "<Leader>an", '<Cmd>AerialNavToggle<CR>',    desc = 'Toggle Aerial nav' },
})

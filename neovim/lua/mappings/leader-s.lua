local wk = require("which-key")
local treesj = require('treesj')

wk.add({
    mode = { "n", "x" },
    { "K",          treesj.toggle,       desc = "Split/join", },
    { "<Leader>s",  group = "+splitjoin" },
    { "<Leader>ss", treesj.toggle,       desc = "Toggle" },
    { "<Leader>sl", treesj.split,        desc = "Split" },
    { "<Leader>sj", treesj.join,         desc = "Join" },
})

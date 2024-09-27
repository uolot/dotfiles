local wk = require("which-key")

wk.add({
    mode = { "n", "x" },
    { "<Leader>k",  group = "Mark and highlight" },
    { "<Leader>kc", "<Plug>MarkClear",           desc = "Clear mark", },
    { "<Leader>kg", "V:<C-u>HSHighlight 5<CR>",  desc = "Highlight line green", },
    { "<Leader>kk", "<Plug>MarkSet",             desc = "Set mark", },
    { "<Leader>kl", "V:<C-u>HSHighlight 1<CR>",  desc = "Highlight line", },
    { "<Leader>km", "<Plug>MarkToggle",          desc = "Toggle mark", },
    { "<Leader>kr", "V:<C-u>HSHighlight 4<CR>",  desc = "Highlight line red", },
    { "<Leader>kx", "V:<C-u>HSRmHighlight<CR>",  desc = "Remove highlight", },
})

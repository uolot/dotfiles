local wk = require("which-key")

wk.add({
    mode = "n",
    { "<Leader>n",  group = "Neotree" },
    { "<Leader>nb", ":Neotree left buffers toggle<CR>",           desc = "Open buffers" },
    { "<Leader>nj", ":Neotree left last toggle<CR>",              desc = "Toggle left" },
    { "<Leader>nk", ":Neotree right last toggle<CR>",             desc = "Toggle right" },
    { "<Leader>nf", ":Neotree left filesystem reveal<CR>",        desc = "Reveal current file" },
    { "<Leader>ng", ":Neotree left git_status toggle<CR>",        desc = "Git status" },
    { "<Leader>nn", ":Neotree left filesystem toggle<CR>",        desc = "Toggle" },
    { "<Leader>nh", ":Neotree left focus<CR>",                    desc = "Focus left" },
    { "<Leader>nl", ":Neotree right focus<CR>",                   desc = "Focus right" },
    { "<Leader>ns", ":Neotree right document_symbols toggle<CR>", desc = "Document symbols" },
})

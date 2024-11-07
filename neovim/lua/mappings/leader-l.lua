local wk = require("which-key")

wk.add({
    mode = "n",
    { "<Leader>l",  group = "+lazygit" },
    { "<Leader>ll", Snacks.lazygit.open,     desc = "Open lazygit", },
    { "<Leader>lg", Snacks.lazygit.log,      desc = "Open lazygit in log view", },
    { "<Leader>lf", Snacks.lazygit.log_file, desc = "Open lazygit with current file log", },
})

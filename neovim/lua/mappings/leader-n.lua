local wk = require("which-key")

wk.add({
    mode = "n",
    { "<Leader>n",  group = "+explorer" },
    { "<Leader>nc", Snacks.explorer.reveal,       desc = "Reveal current file" },
    { "<Leader>nn", Snacks.explorer.open,         desc = "Toggle" },
    { "<Leader>nh", Snacks.notifier.show_history, desc = "Show notification history" },
})

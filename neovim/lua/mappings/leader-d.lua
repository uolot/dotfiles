local wk = require("which-key")
local dapui = require("dapui")

wk.add({
    mode = "n",
    { "<Leader>d",  group = "Diffview & DAP UI" },
    -- Diffview
    { "<Leader>dc", "<Cmd>DiffviewClose<CR>",         desc = "Diffview: Close" },
    { "<Leader>dh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview: File history" },
    { "<Leader>do", "<Cmd>DiffviewOpen<CR>",          desc = "Diffview: Open" },
    -- DAP
    { "<Leader>dt", dapui.toggle,                     desc = "DAP UI: Toggle" },
    { "<Leader>df", dapui.float_element,              desc = "DAP UI: Open float" },
    { "<Leader>de", dapui.eval,                       desc = "DAP UI: Evaluate expression" },
})

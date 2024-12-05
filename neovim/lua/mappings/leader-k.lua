local wk = require("which-key")

wk.add({
    { "<Leader>k", group = "Highlight" },
    -- highlight words
    {
        mode = { "n" },
        { "<Leader>kc", "<Plug>MarkClear",             desc = "Clear current mark" },
        { "<Leader>kC", "<Plug>MarkAllClear",          desc = "Clear all marks" },
        { "<Leader>kk", "<Plug>MarkSet",               desc = "Set mark" },
        { "<Leader>km", "<Plug>MarkToggle",            desc = "Toggle mark" },
        { "]k",         "<Plug>MarkSearchCurrentNext", desc = "Search current mark next" },
        { "[k",         "<Plug>MarkSearchCurrentPrev", desc = "Search current mark prev" },
        { "<Leader>kn", "<Plug>MarkSearchAnyNext",     desc = "Search any mark next" },
        { "<Leader>kp", "<Plug>MarkSearchAnyPrev",     desc = "Search any mark prev" },
        -- TODO: figure out how this works
        -- { "<Leader>kw", "<Plug>MarkPartialWord",       desc = "Mark partial word" },
        -- { "<Leader>ke", "<Plug>MarkRegex",             desc = "Mark regex" },
        -- highlight lines
        { "<Leader>kl", "V:<C-u>HSHighlight 1<CR>",    desc = "Highlight line" },
        { "<Leader>kg", "V:<C-u>HSHighlight 5<CR>",    desc = "Highlight line green" },
        { "<Leader>kr", "V:<C-u>HSHighlight 4<CR>",    desc = "Highlight line red" },
        { "<Leader>kx", "V:<C-u>HSRmHighlight<CR>",    desc = "Remove line highlight" },
    },
    {
        mode = { "x" },
        { "<Leader>kk", "<Plug>MarkSet", desc = "Set mark" },
        -- TODO: figure out how this works
        -- { "<Leader>kw", "<Plug>MarkPartialWord", desc = "Mark partial word" },
        -- { "<Leader>ke", "<Plug>MarkRegex",       desc = "Mark regex" },
    },
})

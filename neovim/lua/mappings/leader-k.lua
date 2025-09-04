local wk = require("which-key")

wk.add({
    { "<Leader>k", group = "+highlight" },
    -- highlight words
    {
        mode = { "n" },
        { "<Leader>kc", "<Plug>MarkClear",    desc = "Clear current mark" },
        { "<Leader>kC", "<Plug>MarkAllClear", desc = "Clear all marks" },
        { "<Leader>km", "<Plug>MarkToggle",   desc = "Toggle mark" },
        {
            mode = { "n", "x" },
            { "<Leader>kk", "<Plug>MarkSet",   desc = "Set mark" },
            { "<Leader>ke", "<Plug>MarkRegex", desc = "Mark regex" },
        },
        { "<Leader>kw", "<Plug>MarkPartialWord",       desc = "Mark partial word" },
        { "[k",         "<Plug>MarkSearchCurrentPrev", desc = "Search current mark prev" },
        { "]k",         "<Plug>MarkSearchCurrentNext", desc = "Search current mark next" },
        { "[K",         "<Plug>MarkSearchAnyPrev",     desc = "Search any mark prev" },
        { "]K",         "<Plug>MarkSearchAnyNext",     desc = "Search any mark next" },
        -- highlight lines
        { "<Leader>kl", "V:<C-u>HSHighlight 1<CR>",    desc = "Highlight line" },
        { "<Leader>kg", "V:<C-u>HSHighlight 5<CR>",    desc = "Highlight line green" },
        { "<Leader>kr", "V:<C-u>HSHighlight 4<CR>",    desc = "Highlight line red" },
        { "<Leader>kx", "V:<C-u>HSRmHighlight<CR>",    desc = "Remove line highlight" },
    },
})

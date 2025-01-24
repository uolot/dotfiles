local opts = {
    signs = true,
    keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "fixme" } },
        TODO = { icon = " ", color = "info", alt = { "it.todo", "test.todo" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = {} },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "it.skip", "test.skip" } },
        TEST = { icon = "⏲ ", color = "test", alt = {} },
    },
    merge_keywords = true,
    highlight = {
        multiline = false,
        comments_only = false,
        before = "fg",
        keyword = "bg",
        after = "fg",
        pattern = {
            -- [[.*<(KEYWORDS)( |:|;|\s+|\.|,|;|$)]],
            [[.*<(KEYWORDS)\s*]],
            -- [[.*<(KEYWORDS)\s*(\(.*\))?\s*:?]],
        },
        exclude = {
            "TelescopePrompt",
            "TelescopeResults",
            "help",
            "lazy",
            "lspinfo",
            "mason",
            "nvcheatsheet",
            "nvdash",
            "terminal",
            'nerdtree',
            'unite',
            'OverseerForm',
            'OverseerList',
        },
    },
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        pattern = [[\b(KEYWORDS)\b]],         -- match without the extra colon. You'll likely get false positives
    },

}

return { opts = opts }

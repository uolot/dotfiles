return {
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = false,
            sections = {
                { section = "header" },
                { section = "startup", padding = 1 },
            },
        },
        indent = {
            enabled = true,
            animate = { enabled = false },
            scope = { enabled = true, },
            chunk = {
                enabled = true,
                char = {
                    corner_top = "╭",
                    corner_bottom = "╰",
                    horizontal = "─",
                    vertical = "│",
                    arrow = "─",
                },
            },
        },
        input = {
            enabled = true,
            relative = 'cursor',
            row = -3,
            col = 0,
        },
        notifier = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = {
            enabled = true,
            left = { "mark", "fold" }, -- priority of signs on the left (high to low)
            right = { "sign", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = true,           -- show open fold icons
                git_hl = false,        -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },
        words = {
            enabled = true,
            debounce = 200,
            notify_jump = false,
            notify_end = true,
        },
    }
}

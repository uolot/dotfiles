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
        notifier = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false },
        words = {
            enabled = true,
            debounce = 200,
            notify_jump = false,
            notify_end = true,
        },
    }
}

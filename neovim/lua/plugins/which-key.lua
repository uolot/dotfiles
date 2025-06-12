local opts = {
    preset = "modern",
    notify = true,
    marks = true,
    registers = true,
    spelling = {
        enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
    },
    triggers = {
        { "<auto>", mode = "nixsotc" },
        { "s",      mode = { "n", "v" } },
    }
}

return { opts = opts }

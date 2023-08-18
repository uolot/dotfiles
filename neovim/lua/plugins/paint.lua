local opts = {
    highlights = {
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*#%s+.+)",
            hl = "markdownH1",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*##%s+.+)",
            hl = "markdownH2",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*###%s+.+)",
            hl = "markdownH3",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*####%s+.+)",
            hl = "markdownH4",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*#####%s+.+)",
            hl = "markdownH5",
        },
    },
}

return { opts = opts }

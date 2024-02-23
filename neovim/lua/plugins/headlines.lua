local function config()
    require('headlines').setup({
        markdown = {
            -- query = vim.treesitter.parse_query(
            query = vim.treesitter.query.parse(
                "markdown",
                [[
                            (atx_heading [
                                (atx_h1_marker)
                                (atx_h2_marker)
                                (atx_h3_marker)
                                (atx_h4_marker)
                                (atx_h5_marker)
                                (atx_h6_marker)
                            ] @headline)

                            (thematic_break) @dash

                            (fenced_code_block) @codeblock

                            (block_quote_marker) @quote
                            (block_quote (paragraph (inline (block_continuation) @quote)))
                            (block_quote (paragraph (block_continuation) @quote))
                            (block_quote (block_continuation) @quote)
                        ]]
            ),
            headline_highlights = {
                -- "Headline1",
                -- "Headline2",
                -- "Headline3",
                -- "Headline4",
                -- "Headline5",
            },
            bullets = {},
            codeblock_highlight = "",
            dash_highlight = "Dash",
            dash_string = "─",
            quote_highlight = "Quote",
            quote_string = "┃",
            fat_headlines = false,
            -- fat_headline_upper_string = "▄",
            -- fat_headline_lower_string = "▀",
        },
    })
end

return { config = config }

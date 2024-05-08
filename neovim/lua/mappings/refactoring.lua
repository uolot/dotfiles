return {
    extract = {
        name = '+extract',
        f = { ":Refactor extract ", "Extract function", mode = { "x" } },
        F = { ":Refactor extract_to_file ", "Extract function to file", mode = { "x" } },
        v = { ":Refactor extract_var ", "Extract variable", mode = { "x" } },
        b = { ":Refactor extract_block ", "Extract block", mode = { "n" } },
        B = { ":Refactor extract_block_to_file ", "Extract block to file", mode = { "n" } },
    },
    inline = {
        name = '+inline',
        v = { ":Refactor inline_var ", "Inline variable", mode = { "n", "x" } },
        f = { ":Refactor inline_func ", "Inline function", mode = { "n" } },
    },
}

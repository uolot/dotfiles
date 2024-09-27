local wk = require("which-key")

local function telescope_refactors()
    require('telescope').extensions.refactoring.refactors()
end


wk.add({
    mode = { "n", "x" },
    { "<Leader>r",  group = "+refactor" },
    { "<Leader>rt", telescope_refactors, desc = "Telescope" },
    {
        { "<Leader>re", group = "+extract" },
        {
            mode = "x",
            { "<Leader>ref", ":Refactor extract ",         desc = "Extract function", },
            { "<Leader>reF", ":Refactor extract_to_file ", desc = "Extract function to file", },
            { "<Leader>rev", ":Refactor extract_var ",     desc = "Extract variable", },
        },
        {
            mode = "n",
            { "<Leader>reb", ":Refactor extract_block ",         desc = "Extract block", },
            { "<Leader>reB", ":Refactor extract_block_to_file ", desc = "Extract block to file", },
        },
    },
    {
        { "<Leader>ri",  group = "+inline" },
        { "<Leader>riv", ":Refactor inline_var ",  desc = "Inline variable", },
        { "<Leader>rif", ":Refactor inline_func ", desc = "Inline function", },
    }
})

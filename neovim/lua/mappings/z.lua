local wk = require("which-key")

wk.add({
    mode = "n",
    {
        "zR",
        function()
            require('ufo').openAllFolds()
        end,
        desc = "Open all folds",
    },
    {
        "zM",
        function()
            require('ufo').closeAllFolds()
        end,
        desc = "Close all folds",
    },
})

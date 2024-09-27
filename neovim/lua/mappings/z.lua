local wk = require("which-key")
local ufo = require("ufo")

wk.add({
    mode = "n",
    { "zR", ufo.openAllFolds,  desc = "Open all folds" },
    { "zM", ufo.closeAllFolds, desc = "Close all folds" },
})

local function config()
    -- vim.o.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T@v:lua.ScNa@%=%{v:lua.ScLn()}%T"
    local scb = require("statuscol.builtin")
    require("statuscol").setup({
        -- foldfunc = "builtin",
        setopt = true,
        relculright = true,
        segments = {
            { text = { scb.foldfunc }, click = "v:lua.ScFa" },
            { text = { scb.lnumfunc }, click = "v:lua.ScLa", },
            { text = { " %s" },        click = "v:lua.ScSa" },
        }
    })
end

return { config = config }

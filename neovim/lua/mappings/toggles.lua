local function vim_opt_toggle(opt, on, off)
    local message = opt
    if vim.opt[opt]:get() == off then
        vim.opt[opt] = on
        message = message .. ' -> ' .. vim.inspect(on)
    else
        vim.opt[opt] = off
        message = message .. ' -> ' .. vim.inspect(off)
    end
    vim.notify(message)
end

local function toggle_diagnostic()
    if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
        vim.notify('diagnostic -> true')
    else
        vim.diagnostic.disable()
        vim.notify('diagnostic -> false')
    end
end

return {
    name = "+toggles",
    b = { function() vim_opt_toggle('background', 'light', 'dark') end, "Background" },
    d = { toggle_diagnostic, "Diagnostics" },
    i = { function() vim.lsp.buf.inlay_hint(0) end, "Inlay hints" },
    r = { function() vim_opt_toggle('relativenumber', true, false) end, "Relative number" },
    w = { function() vim_opt_toggle('wrap', true, false) end, "Line wrap" },
}
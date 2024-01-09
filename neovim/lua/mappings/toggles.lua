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
    -- b = { function() vim_opt_toggle('background', 'light', 'dark') end, "Background" },
    b = { function() require('bamboo').toggle() end, "Background" },
    d = { toggle_diagnostic, "Diagnostics" },
    -- TODO: change to .toggle() when implemented
    -- i = { function() vim.lsp.inlay_hint.enable(vim.api.nvim_get_current_buf()) end, "Inlay hints" },
    i = {
        name = "+inlay hints",
        i = { function() vim.lsp.inlay_hint.enable(vim.api.nvim_get_current_buf(), false) end, "Disable inlay hints" },
        I = { function() vim.lsp.inlay_hint.enable(vim.api.nvim_get_current_buf(), true) end, "Enable inlay hints" },
    },
    r = { function() vim_opt_toggle('relativenumber', true, false) end, "Relative number" },
    t = { require('buffertabs').toggle, 'Buffer tabs' },
    w = { function() vim_opt_toggle('wrap', true, false) end, "Line wrap" },
}

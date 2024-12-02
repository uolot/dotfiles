local opts = {
    windows = {
        preview = true,
        width_preview = 50,
    },
    mappings = {
        close       = 'q',
        go_in       = '<Right>',
        go_in_plus  = '<Enter>',
        go_out      = '<Left>',
        go_out_plus = nil,
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
    },
}

local function files_setup(_, _opts)
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
            Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
    })

    require('mini.files').setup(opts)
end

return {
    files = { config = files_setup }
}

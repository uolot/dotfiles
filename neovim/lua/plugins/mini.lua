local opts = {
    windows = {
        preview = true,
        width_preview = 50,
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

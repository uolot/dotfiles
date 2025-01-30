local dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        version = "1.*",
        config = function()
            require 'window-picker'.setup({
                autoselect_one = true,
                include_current = false,
                filter_rules = {
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { 'neo-tree', "neo-tree-popup", "notify", "smear-cursor" },

                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { 'terminal', "quickfix" },
                    },
                },
                other_win_hl_color = '#e35e4f',
            })
        end,
    }
}

local opts = function(_, opts)
    opts.popup_border_style = "rounded"
    opts.sources = {
        'filesystem',
        'git_status',
        'document_symbols',
        'buffers',
    }

    local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
    end

    local events = require('neo-tree.events')
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
    })
end

return {
    dependencies = dependencies,
    opts = opts,
}

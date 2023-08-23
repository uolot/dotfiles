return {
    ['<C-m>'] = { '<Cmd>WinShift<CR>', 'Move window mode' },
    m = { '<Cmd>WinShift<CR>', 'Move window mode' },
    x = { '<Cmd>WinShift swap<CR>' },
    g = {
        name = '+move window',
        h = { '<Cmd>WinShift left<CR>', 'Move left' },
        j = { '<Cmd>WinShift down<CR>', 'Move down' },
        k = { '<Cmd>WinShift up<CR>', 'Move up' },
        l = { '<Cmd>WinShift right<CR>', 'Move right' },
    },
    p = {
        function()
            local winid = require('winpick').select()
            if winid then
                vim.api.nvim_set_current_win(winid)
            end
        end,
        'Pick a window'
    }
}

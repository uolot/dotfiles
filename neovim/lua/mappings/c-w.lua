local wk = require('which-key')

local function pick_window()
    local winid = require('winpick').select()
    if winid then
        vim.api.nvim_set_current_win(winid)
    end
end

wk.add({
    { "<C-w><C-m>", '<Cmd>WinShift<CR>',      desc = 'Enter window move mode' },
    { "<C-w>m",     '<Cmd>WinShift<CR>',      desc = 'Enter window move mode' },
    { "<C-w>p",     pick_window,              desc = 'Pick a window' },
    { "<C-w>x",     '<Cmd>WinShift swap<CR>', desc = 'Swap windows' },
    {
        { "<C-w>g",  group = 'Move window' },
        { "<C-w>gh", '<Cmd>WinShift left<CR>',  desc = 'Move left' },
        { "<C-w>gj", '<Cmd>WinShift down<CR>',  desc = 'Move down' },
        { "<C-w>gk", '<Cmd>WinShift up<CR>',    desc = 'Move up' },
        { "<C-w>gl", '<Cmd>WinShift right<CR>', desc = 'Move right' },
    },
})

local gs = require('gitsigns')
-- local gs = package.loaded.gitsigns

return {
    name = '+gitsigns/harpoon',

    -- gitsigns

    b = { function() gs.blame_line({ full = false }) end, 'Blame line' },
    B = { function() gs.blame_line({ full = true }) end, 'Blame line (full)' },

    i = { gs.preview_hunk_inline, 'Preview hunk inline' },
    p = { gs.preview_hunk, 'Preview hunk' },

    s = { gs.stage_hunk, 'Stage hunk', mode = { 'n', 'x' } },
    S = { gs.stage_buffer, 'Stage buffer' },
    r = { gs.reset_hunk, 'Reset hunk', mode = { 'n', 'x' } },
    R = { gs.reset_buffer, 'Reset buffer' },
    u = { gs.undo_stage_hunk, 'Undo stage hunk' },

    l = { gs.setloclist, 'Set loclist' },
    q = { gs.setqflist, 'Set qflist' },

    o = {
        name = '+open in gh',
        f = { '<Cmd>OpenInGHFile<CR>', 'Open file (default branch)' },
        F = { '<Cmd>OpenInGHFile!<CR>', 'Open file (HEAD)' },
        l = { "<Cmd>'<,'>OpenInGHFileLines<CR>", 'Open lines (default branch)', mode = { 'x' } },
        L = { "<Cmd>'<,'>OpenInGHFileLines!<CR>", 'Open lines (HEAD)', mode = { 'x' } },
        r = { '<Cmd>OpenInGHRepo<CR>', 'Open repo' },
        y = { '<Cmd>OpenInGHFile+<CR>', 'Copy file link to system clipboard (default branch)' },
        Y = { '<Cmd>OpenInGHFile!+<CR>', 'Copy file link to system clipboard (HEAD)' },
    },
    x = {
        name = '+toggles',
        b = { gs.toggle_current_line_blame, 'Toggle current line blame' },
        B = { '<Cmd>ToggleBlame virtual<CR>', 'Blame entire file' },
        d = { gs.toggle_deleted, 'Toggle deleted' },
        l = { gs.toggle_linehl, 'Toggle line highlight' },
        w = { gs.toggle_word_diff, 'Toggle word diff' },
    },
    --        map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    --        map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

    -- harpoon

    m = { require('harpoon.ui').toggle_quick_menu, 'Harpoon menu' },
    a = { require('harpoon.mark').add_file, 'Harpoon add file' },
    j = { require('harpoon.ui').nav_next, 'Harpoon next' },
    k = { require('harpoon.ui').nav_prev, 'Haroon prev' },
    ["1"] = { function() require('harpoon.ui').nav_file(1) end, 'Harpoon 1' },
    ["2"] = { function() require('harpoon.ui').nav_file(2) end, 'Harpoon 2' },
    ["3"] = { function() require('harpoon.ui').nav_file(3) end, 'Harpoon 3' },
    ["4"] = { function() require('harpoon.ui').nav_file(4) end, 'Harpoon 4' },
    ["5"] = { function() require('harpoon.ui').nav_file(5) end, 'Harpoon 5' },
    ["6"] = { function() require('harpoon.ui').nav_file(6) end, 'Harpoon 6' },
    ["7"] = { function() require('harpoon.ui').nav_file(7) end, 'Harpoon 7' },
    ["8"] = { function() require('harpoon.ui').nav_file(8) end, 'Harpoon 8' },
    ["9"] = { function() require('harpoon.ui').nav_file(9) end, 'Harpoon 9' },
}

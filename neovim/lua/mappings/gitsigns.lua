local gs = require('gitsigns')
-- local gs = package.loaded.gitsigns

return {
    name = '+gitsigns',
    b = { function() gs.blame_line({ full = false }) end, 'Blame line' },
    B = { function() gs.blame_line({ full = true }) end, 'Blame line (full)' },

    i = { gs.preview_hunk_inline, 'Preview hunk inline' },
    p = { gs.preview_hunk, 'Preview hunk' },

    s = { gs.stage_hunk, 'Stage hunk', { mode = { 'n', 'x' } } },
    S = { gs.stage_buffer, 'Stage buffer' },
    r = { gs.reset_hunk, 'Reset hunk', { mode = { 'n', 'x' } } },
    R = { gs.reset_buffer, 'Reset buffer' },
    u = { gs.undo_stage_hunk, 'Undo stage hunk' },

    l = { gs.setloclist, 'Set loclist' },
    q = { gs.setqflist, 'Set qflist' },

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
}

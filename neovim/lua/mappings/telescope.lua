local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

return {
    name = '+telescope',
    a = { ':Ag ', 'Ag', silent = false },
    b = { builtin.buffers, 'Buffers' },
    d = { '<Cmd>TodoTelescope<CR>', 'Todos' },
    e = { builtin.emoji, 'Emoji' },
    g = { function() builtin.grep_string({ word_match = '-w' }) end, 'Grep word under cursor' },
    G = { builtin.grep_string, 'Grep text under cursor' },
    l = { builtin.live_grep, 'Live grep' },
    L = { extensions.live_grep_args.live_grep_args, 'Live grep args' },
    r = { builtin.resume, 'Resume' },
    u = { extensions.undo.undo, 'Undo tree' },
    z = { builtin.current_buffer_fuzzy_find, 'Current buffer fuzzy find' },
}

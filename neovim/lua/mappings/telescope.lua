local telescope_builtin = require('telescope.builtin')

return {
    name = '+telescope',
    a = { ':Ag ', 'Ag', silent = false },
    b = { telescope_builtin.buffers, 'Buffers' },
    d = { '<Cmd>TodoTelescope<CR>', 'Todos' },
    e = { telescope_builtin.emoji, 'Emoji' },
    g = { function() telescope_builtin.grep_string({ word_match = '-w' }) end, 'Grep word under cursor' },
    G = { telescope_builtin.grep_string, 'Grep text under cursor' },
    l = { telescope_builtin.live_grep, 'Live grep' },
    L = { require("telescope").extensions.live_grep_args.live_grep_args, 'Live grep args' },
    r = { telescope_builtin.resume, 'Resume' },
    z = { telescope_builtin.current_buffer_fuzzy_find, 'Current buffer fuzzy find' },
}

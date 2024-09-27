local wk = require('which-key')
local telescope = require('telescope.builtin')
local undo_tree = require('telescope').extensions.undo
local live_grep_args = require('telescope').extensions.live_grep_args

local function grep_word()
    telescope.grep_string({ word_match = '-w' })
end

wk.add({
    mode = "n",
    { "<Leader>t",  group = "Telescope" },
    { "<Leader>ta", ':Ag ',                              desc = 'Ag',                       silent = false },
    { "<Leader>tb", telescope.buffers,                   desc = 'Buffers' },
    { "<Leader>td", '<Cmd>TodoTelescope<CR>',            desc = 'Todos' },
    { "<Leader>te", telescope.emoji,                     desc = 'Emoji' },
    { "<Leader>tg", grep_word,                           desc = 'Grep word under cursor' },
    { "<Leader>tG", telescope.grep_string,               desc = 'Grep text under cursor' },
    { "<Leader>tl", telescope.live_grep,                 desc = 'Live grep' },
    { "<Leader>tL", live_grep_args.live_grep_args,       desc = 'Live grep args' },
    { "<Leader>tr", telescope.resume,                    desc = 'Resume' },
    { "<Leader>tu", undo_tree.undo,                      desc = 'Undo tree' },
    { "<Leader>t/", telescope.current_buffer_fuzzy_find, desc = 'Current buffer fuzzy find' },
})

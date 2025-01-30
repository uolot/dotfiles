local wk = require('which-key')
local live_grep_args = require('telescope').extensions.live_grep_args

wk.add({
    mode = "n",
    { "<Leader>t",  group = "Telescope" },
    { "<Leader>ta", ':Ag ',                        desc = 'Ag',                       silent = false },
    { "<Leader>tb", Snacks.picker.buffers,         desc = 'Buffers' },
    { "<Leader>tc", Snacks.picker.command_history, desc = 'Command history' },
    { "<Leader>td", Snacks.picker.todo_comments,   desc = 'Todos' },
    { "<Leader>tg", Snacks.picker.grep_word,       desc = 'Grep word under cursor' },
    { "<Leader>tl", Snacks.picker.grep,            desc = 'Live grep' },
    { "<Leader>tL", live_grep_args.live_grep_args, desc = 'Live grep args' },
    { "<Leader>tr", Snacks.picker.resume,          desc = 'Resume' },
    { "<Leader>ts", Snacks.picker.search_history,  desc = 'Search history' },
    { "<Leader>tt", Snacks.picker.smart,           desc = 'Smart' },
    { "<Leader>tu", Snacks.picker.undo,            desc = 'Undo tree' },
    { "<Leader>tz", Snacks.picker.zoxide,          desc = 'Zoxide' },
    { "<Leader>t/", Snacks.picker.lines,           desc = 'Current buffer fuzzy find' },
})

local wk = require('which-key')

local function grep_word()
    Snacks.picker.grep_word({
        args = { "-w" },
        matcher = {
            ignorecase = false,
        },
    })
end

wk.add({
    mode = "n",
    { "<Leader>t",  group = "Telescope" },
    { "<Leader>ta", ':Ag ',                        desc = 'Ag',                       silent = false },
    { "<Leader>tb", Snacks.picker.buffers,         desc = 'Buffers' },
    { "<Leader>tc", Snacks.picker.command_history, desc = 'Command history' },
    ---@diagnostic disable-next-line: undefined-field
    { "<Leader>td", Snacks.picker.todo_comments,   desc = 'Todos' },
    { "<Leader>tg", grep_word,                     desc = 'Grep word under cursor' },
    { "<Leader>tl", Snacks.picker.grep,            desc = 'Live grep' },
    { "<Leader>tp", Snacks.picker.pickers,         desc = 'All pickers' },
    { "<Leader>tr", Snacks.picker.resume,          desc = 'Resume' },
    { "<Leader>ts", Snacks.picker.search_history,  desc = 'Search history' },
    { "<Leader>tq", Snacks.picker.qflist,          desc = 'Quickfix list' },
    ---@diagnostic disable-next-line: undefined-field
    { "<Leader>tt", Snacks.picker.smart,           desc = 'Smart' },
    ---@diagnostic disable-next-line: undefined-field
    { "<Leader>tu", Snacks.picker.undo,            desc = 'Undo tree' },
    ---@diagnostic disable-next-line: undefined-field
    { "<Leader>tz", Snacks.picker.spelling,        desc = 'Spelling' },
    { "<Leader>t/", Snacks.picker.lines,           desc = 'Current buffer fuzzy find' },
})

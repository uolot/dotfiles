local wk = require('which-key')

local function buffers()
    Snacks.picker.buffers({ formatters = { file = { truncate = 100 } } })
end

local function grep()
    Snacks.picker.grep({
        formatters = { file = { truncate = 100 }, },
    })
end

local function grep_word()
    Snacks.picker.grep_word({
        args = { "-w" },
        matcher = {
            ignorecase = false,
        },
        formatters = {
            file = { truncate = 100 },
        },
    })
end

local function grep_word_everywhere()
    Snacks.picker.grep_word({
        args = { "-w", "--hidden" },
        matcher = {
            ignorecase = false,
        },
        formatters = {
            file = { truncate = 100 },
        },
    })
end

wk.add({
    mode = "n",
    { "<Leader>t",  group = "+pickers" },
    { "<Leader>tb", buffers,                       desc = 'Buffers' },
    { "<Leader>tc", Snacks.picker.command_history, desc = 'Command history' },
    ---@diagnostic disable-next-line: undefined-field
    { "<Leader>td", Snacks.picker.todo_comments,   desc = 'Todos' },
    { "<Leader>tg", grep_word,                     desc = 'Grep word under cursor' },
    { "<Leader>tG", grep_word_everywhere,          desc = 'Grep word under cursor' },
    { "<Leader>tl", grep,                          desc = 'Live grep' },
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

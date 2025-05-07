local wk = require("which-key")

local function todo_comments()
    ---@diagnostic disable-next-line: undefined-field
    Snacks.picker.todo_comments()
end

wk.add({
    mode = "n",
    { "<Leader>p",    group = "+pickers" },
    -- Commands
    { "<Leader>pc",   group = "+commands" },
    { "<Leader>pcc",  Snacks.picker.commands,           desc = "Commands" },
    { "<Leader>pch",  Snacks.picker.command_history,    desc = "Command history" },
    -- Diagnostics
    { "<Leader>pd",   group = "+diagnostics" },
    { "<Leader>pdd",  Snacks.picker.diagnostics_buffer, desc = "Show buffer diagnostics" },
    { "<Leader>pda",  Snacks.picker.diagnostics,        desc = "Show all diagnostics" },
    -- Git
    { "<Leader>pg",   group = "+git" },
    { "<Leader>pgb",  Snacks.picker.git_branches,       desc = "Git branches" },
    { "<Leader>pgd",  Snacks.picker.git_diff,           desc = "Git diff" },
    { "<Leader>pgs",  Snacks.picker.git_stash,          desc = "Git stash" },
    -- Git -> logs
    { "<Leader>pgl",  group = "+git_log" },
    { "<Leader>pglg", Snacks.picker.git_log,            desc = "Git log" },
    { "<Leader>pglf", Snacks.picker.git_log_file,       desc = "Git log file" },
    { "<Leader>pgll", Snacks.picker.git_log_line,       desc = "Git log line" },
    -- Help
    { "<Leader>phe",  Snacks.picker.help,               desc = "Help" },
    -- Highlights
    { "<Leader>phl",  Snacks.picker.highlights,         desc = "Highlights" },
    -- Icons
    { "<Leader>pic",  Snacks.picker.icons,              desc = "Icons" },
    -- Keymaps
    { "<Leader>pk",   Snacks.picker.keymaps,            desc = "Keymaps" },
    -- Lines
    { "<Leader>pl",   Snacks.picker.lines,              desc = "Lines" },
    -- Marks
    { "<Leader>pm",   Snacks.picker.marks,              desc = "Marks" },
    -- Notifications
    { "<Leader>pn",   Snacks.picker.notifications,      desc = "Notifications" },
    -- Pickers
    { "<Leader>pp",   Snacks.picker.pickers,            desc = "Show all pickers" },
    -- Quickfix
    { "<Leader>pq",   Snacks.picker.qflist,             desc = "Quickfix" },
    -- Todo comments
    { "<Leader>pt",   todo_comments,                    desc = "Todo comments" },
    -- Undo
    { "<Leader>pu",   Snacks.picker.undo,               desc = "Undo history" },
})

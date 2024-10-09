local wk = require("which-key")
local gs = require('gitsigns')

local function blame_line()
    gs.blame_line({ full = false })
end

local function blame_line_full()
    gs.blame_line({ full = true })
end

wk.add({
    mode = 'n',
    { "<Leader>h",  group = "Git" },
    -- add
    { "<Leader>hA", '<Cmd>!git add %<CR><CR>', desc = 'Add file',           silent = true },
    -- blame
    { "<Leader>hb", blame_line,                desc = 'Blame line' },
    { "<Leader>hB", blame_line_full,           desc = 'Blame line (full)' },
    -- preview hunk
    { "<Leader>hi", gs.preview_hunk_inline,    desc = 'Preview hunk inline' },
    { "<Leader>hp", gs.preview_hunk,           desc = 'Preview hunk' },
    -- stage and reset
    {
        { "<Leader>hs", gs.stage_hunk,      desc = 'Stage hunk',     mode = { 'n', 'x' } },
        { "<Leader>hS", gs.stage_buffer,    desc = 'Stage buffer' },
        { "<Leader>hr", gs.reset_hunk,      desc = 'Reset hunk',     mode = { 'n', 'x' } },
        { "<Leader>hR", gs.reset_buffer,    desc = 'Reset buffer' },
        { "<Leader>hu", gs.undo_stage_hunk, desc = 'Undo stage hunk' },
    },
    -- set loclist and qflist
    { "<Leader>hl",  gs.setloclist,            desc = 'Set loclist' },
    { "<Leader>hq",  gs.setqflist,             desc = 'Set qflist' },
    -- open in GitHub
    { "<Leader>ho",  group = "Open in GitHub" },
    { "<Leader>hor", '<Cmd>OpenInGHRepo<CR>',  desc = 'Open repo' },
    { "<Leader>hof", '<Cmd>OpenInGHFile<CR>',  desc = 'Open file (default branch)' },
    { "<Leader>hoF", '<Cmd>OpenInGHFile!<CR>', desc = 'Open file (HEAD)' },
    {
        mode = "x",
        { "<Leader>hol", "<Cmd>'<,'>OpenInGHFileLines<CR>",  desc = 'Open lines (default branch)' },
        { "<Leader>hoL", "<Cmd>'<,'>OpenInGHFileLines!<CR>", desc = 'Open lines (HEAD)' },
    },
    { "<Leader>hoy", '<Cmd>OpenInGHFile+<CR>',     desc = 'Copy file link to system clipboard (default branch)' },
    { "<Leader>hoY", '<Cmd>OpenInGHFile!+<CR>',    desc = 'Copy file link to system clipboard (HEAD)' },
    -- toggles
    { "<Leader>hx",  group = "Toggles" },
    { "<Leader>hxb", gs.toggle_current_line_blame, desc = 'Toggle current line blame' },
    { "<Leader>hxB", '<Cmd>Gitsigns blame<CR>',    desc = 'Blame entire file' },
    { "<Leader>hxd", gs.toggle_deleted,            desc = 'Toggle deleted' },
    { "<Leader>hxl", gs.toggle_linehl,             desc = 'Toggle line highlight' },
    { "<Leader>hxw", gs.toggle_word_diff,          desc = 'Toggle word diff' },
})

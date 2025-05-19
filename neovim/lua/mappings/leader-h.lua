local wk = require("which-key")
local gs = require('gitsigns')

local function blame_line()
    gs.blame_line({ full = false })
end

local function blame_line_full()
    gs.blame_line({ full = true })
end

local function stage_selected_hunk()
    gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
end

local function reset_selected_hunk()
    gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
end

local function diffthis()
    gs.diffthis('~')
end

wk.add({
    mode = 'n',
    { "<Leader>h",   group = "Git" },
    -- add
    { "<Leader>hA",  '<Cmd>!git add %<CR>',            desc = 'Add file',           silent = true },
    -- delete
    { "<Leader>hD",  "<Cmd>!git rm -f '%'<CR>",        desc = 'Delete file',        silent = true },
    -- blame
    { "<Leader>hb",  blame_line,                       desc = 'Blame line' },
    { "<Leader>hB",  blame_line_full,                  desc = 'Blame line (full)' },
    -- diffview
    { "<Leader>hf",  "<Cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    { "<Leader>hdo", "<Cmd>DiffviewOpen<CR>",          desc = "Diffview open  " },
    { "<Leader>hdc", "<Cmd>DiffviewClose<CR>",         desc = "Diffview close" },
    { "<Leader>hdt", diffthis,                         desc = "Diffview close" },
    -- preview hunk
    { "<Leader>hi",  gs.preview_hunk_inline,           desc = 'Preview hunk inline' },
    { "<Leader>hp",  gs.preview_hunk,                  desc = 'Preview hunk' },
    -- stage and reset
    {
        mode = 'n',
        { "<Leader>hs", gs.stage_hunk,   desc = 'Stage hunk', },
        { "<Leader>hS", gs.stage_buffer, desc = 'Stage buffer' },
        { "<Leader>hr", gs.reset_hunk,   desc = 'Reset hunk', },
        { "<Leader>hR", gs.reset_buffer, desc = 'Reset buffer' },
    },
    {
        mode = 'v',
        { "<Leader>hs", stage_selected_hunk, desc = 'Stage hunk', },
        { "<Leader>hr", reset_selected_hunk, desc = 'Reset hunk', },
    },
    -- set loclist and qflist
    { "<Leader>hl", gs.setloclist, desc = 'Set loclist' },
    { "<Leader>hq", gs.setqflist,  desc = 'Set qflist' },
    -- open in GitHub
    {
        { "<Leader>ho",  group = "Open in GitHub" },
        { "<Leader>hor", function() Snacks.gitbrowse({ what = "repo" }) end,                  desc = 'Open repo' },
        { "<Leader>hof", function() Snacks.gitbrowse({ what = "file" }) end,                  desc = 'Open file' },
        { "<Leader>hoF", function() Snacks.gitbrowse({ what = "file", branch = "main" }) end, desc = 'Open file on main' },
        {
            mode = 'v',
            {
                "<Leader>hof",
                function()
                    Snacks.gitbrowse({
                        what = "file",
                        line_start = vim.fn.line("<"),
                        line_end = vim.fn.line("'>"),

                    })
                end,
                desc = 'Open selected'
            },
        },
    },
    -- toggles
    {
        { "<Leader>hx",  group = "Toggles" },
        { "<Leader>hxb", gs.toggle_current_line_blame, desc = 'Toggle current line blame' },
        { "<Leader>hxB", '<Cmd>Gitsigns blame<CR>',    desc = 'Blame entire file' },
        { "<Leader>hxl", gs.toggle_linehl,             desc = 'Toggle line highlight' },
        { "<Leader>hxw", gs.toggle_word_diff,          desc = 'Toggle word diff' },
    },
})

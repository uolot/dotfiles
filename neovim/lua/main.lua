require('plugins.lazy')

require('impatient')
vim.loader.enable()

require('config.lsp')
require('config.diagnostics')

-- TODO: move to mappings
vim.keymap.set('n', '<C-w>p', function()
    local winid = require('winpick').select()
    if winid then
        vim.api.nvim_set_current_win(winid)
    end
end);

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#444444 gui=nocombine]]
-- -- vim.cmd [[highlight IndentBlanklineContextChar guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#909090 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=#909090 gui=underline]]

local function close_floating()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        -- if config.relative == 'win' then
        if config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

require('which-key').register(
    {
        ["<Esc>"] = { close_floating, "Close all floating windows" },
    },
    { mode = 'n' }
)

require('mappings')

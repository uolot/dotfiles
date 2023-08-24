local wk = require('which-key')
local telescope_builtin = require('telescope.builtin')

local function close_floating()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        -- if config.relative == 'win' then
        if config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

wk.register({
    ["<Esc>"] = { close_floating, "Close all floating windows" },
    ["<Backspace>"] = { '<C-^>', "Quick buffer switch" },
    ["<C-Tab>"] = { '<C-n>', "Next completion" },
    ["<C-S-Tab>"] = { '<C-n>', "Previous completion" },
    ["<C-h>"] = { '<C-w>h', "Move left" },
    ["<C-j>"] = { "<C-w>j", "Move down" },
    ["<C-k>"] = { "<C-w>k", "Move up" },
    ["<C-l>"] = { "<C-w>l", "Move right" },
    -- K = { require('trevj').format_at_cursor, 'Split' },
    ['<'] = { '<gv', 'Indent left', mode = 'v' },
    ['>'] = { '<gv', 'Indent right', mode = 'v' },
    g = require('mappings.g'),
    z = require('mappings.z'),
    ["<Leader>"] = {
        d = require('mappings.diffview'),
        -- TODO: merge f and t ???
        f = require('mappings.find'),
        g = require('mappings.lsp'),
        h = require('mappings.gitsigns'),
        k = require('mappings.marks'),
        n = require('mappings.neo-tree'),
        t = require('mappings.telescope'),
        x = require('mappings.toggles'),
        z = require('mappings.zk'),
    },
    ['<C-w>'] = require('mappings.c-w'),
})

-- TODO: convert to which-key mappings

vim.keymap.set('x', '.', ':norm.<CR', { noremap = true, silent = true, desc = 'Make dot work in visual' })

--
-- lsp
--
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ wrap = false }) end, { noremap = true, silent = true })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ wrap = false }) end, { noremap = true, silent = true })

--
-- search
--
vim.keymap.set('n', '\\c', '/\\c', { noremap = true, silent = false, desc = 'Case insensitive search' })
vim.keymap.set('n', '\\s', '/\\<\\><left><left>',
    { noremap = true, silent = false, desc = 'Search for word (like grep -w)' })
-- make n/N always go in the same direction
vim.keymap.set('n', 'n', "(v:searchforward ? 'n' : 'N')", { noremap = true, silent = true, expr = true })
vim.keymap.set('n', 'N', "(v:searchforward ? 'N' : 'n')", { noremap = true, silent = true, expr = true })

--
-- navigation
--
-- quickfix
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[q', '<Cmd>cprev<CR>', { noremap = true, silent = true })
-- todo comments
vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { noremap = true, silent = true })
vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { noremap = true, silent = true })
-- jest
vim.cmd [[nnoremap <silent> [j ?^\s\+\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\)\><CR>]]
vim.cmd [[nnoremap <silent> ]j /^\s\+\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\)\><CR>]]

local wk = require('which-key')
local telescope_builtin = require('telescope.builtin')

local function vim_opt_toggle(opt, on, off)
    local message = opt
    if vim.opt[opt]:get() == off then
        vim.opt[opt] = on
        message = message .. ' -> ' .. vim.inspect(on)
    else
        vim.opt[opt] = off
        message = message .. ' -> ' .. vim.inspect(off)
    end
    vim.notify(message)
end

local function toggle_diagnostic()
    if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
        vim.notify('diagnostic -> true')
    else
        vim.diagnostic.disable()
        vim.notify('diagnostic -> false')
    end
end

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
    ["<Leader>"] = {
        d = {
            name = '+diffview',
            c = { '<Cmd>DiffviewClose<CR>', 'Close' },
            f = { '<Cmd>DiffviewFileHistory<CR>', 'File history' },
            o = { '<Cmd>DiffviewOpen<CR>', 'Open' },
        },
        f = {
            name = '+find',
            f = { telescope_builtin.find_files, 'Find files' },
            h = { '<Cmd>Telescope find_files hidden=true<CR>', 'Hidden files' },
            o = { telescope_builtin.oldfiles, 'Open recent files' },
            p = {
                function()
                    local fname = vim.api.nvim_buf_get_name(0)
                    local git_root = require('lspconfig.util').find_git_ancestor(fname)
                    telescope_builtin.find_files({ cwd = git_root })
                end,
                'Find files in git root',
            },
        },
        g = {
            name = '+lsp',
            a = { '<Cmd>CodeActionMenu<CR>', 'Code Action' },
            e = { vim.diagnostic.open_float, 'Show current line diagnostics' },
            d = { vim.lsp.buf.definition, 'Go to definition' },
            D = { vim.lsp.buf.declaration, 'Go to declaration' },
            -- f = { function() telescope_builtin.lsp_references({ fname_width = 50 }) end, 'Find references' },
            -- f = { function() telescope_builtin.lsp_references() end, 'Find references' },
            f = { function() telescope_builtin.lsp_references({ fname_width = 70, trim_text = true }) end,
                'Find references' },
            -- f = { function() telescope_builtin.lsp_references({ show_line = false }) end, 'Find references' },
            h = { vim.lsp.buf.hover, 'Hover' },
            I = { vim.lsp.buf.implementation, 'Go to implementation' },
            i = { telescope_builtin.lsp_incoming_calls, 'Incoming calls' },
            o = { telescope_builtin.lsp_outgoing_calls, 'Outgoing calls' },
            r = { vim.lsp.buf.rename, 'Rename' },
            -- r = { '<Cmd>IncRename <C-r><C-w>', 'Rename' },
            s = { telescope_builtin.lsp_document_symbols, 'Document symbols' },
            S = { telescope_builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols' },
            t = { vim.lsp.buf.type_definition, 'Go to type definition' },
            w = {
                name = '+Workspace',
                a = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
                r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
                l = { vim.lsp.buf.list_workspace_folders, 'List workspace folders' },
            },
            x = { function() telescope_builtin.diagnostics({ bufnr = 0 }) end, 'Buffer diagnostics' },
            X = { telescope_builtin.diagnostics, 'All buffers diagnostics' },
        },
        -- TODO: merge f and t
        k = {
            name = '+mark',
            c = { '<Plug>MarkClear', 'Clear mark', mode = { 'n', 'x' } },
            g = { 'V:<C-u>HSHighlight 5<CR>', 'Highlight line green', mode = { 'n', 'x' } },
            k = { '<Plug>MarkSet', 'Set mark', mode = { 'n', 'x' } },
            l = { 'V:<C-u>HSHighlight 1<CR>', 'Highlight line', mode = { 'n', 'x' } },
            m = { '<Plug>MarkToggle', 'Toggle mark', mode = { 'n', 'x' } },
            r = { 'V:<C-u>HSHighlight 4<CR>', 'Highlight line red', mode = { 'n', 'x' } },
            x = { 'V:<C-u>HSRmHighlight<CR>', 'Remove highlight', mode = { 'n', 'x' } },
        },
        n = {
            name = '+neo-tree',
            c = { ':Neotree left filesystem toggle reveal_file=<cfile><CR>', 'Show file under cursor' },
            d = { ':Neotree left filesystem toggle dir=', 'Open dir', silent = false },
            f = { ':Neotree left filesystem toggle reveal<CR>', 'Show current file' },
            n = { ':Neotree left filesystem toggle<CR>', 'Toggle' },
        },
        t = {
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

        },
        w = {
            name = '+workbench',
            p = { '<Plug>ToggleProjectWorkbench', 'Toggle project workbench' },
            b = { '<Plug>ToggleBranchWorkbench', 'Toggle branch workbench' },
            t = { '<Plug>WorkbenchToggleCheckbox', 'Toggle workbench checkbox' },
        },
        x = {
            name = "+toggles",
            b = { function() vim_opt_toggle('background', 'light', 'dark') end, "Background" },
            d = { toggle_diagnostic, "Diagnostics" },
            i = { function() vim.lsp.buf.inlay_hint(0) end, "Inlay hints" },
            r = { function() vim_opt_toggle('relativenumber', true, false) end, "Relative number" },
            w = { function() vim_opt_toggle('wrap', true, false) end, "Line wrap" },
        },
        z = {
            name = '+zk',
            c = {
                function() vim.ui.input({ prompt = "Title: " }, function(i) vim.cmd('ZkNew {title="' .. i .. '"}') end) end,
                'New note' },
            b = { '<Cmd>ZkBackLinks<CR>', 'Backlinks' },
            f = { '<Cmd>ZkNotes<CR>', 'Find a note' },
            l = { '<Cmd>ZkLinks<CR>', 'Links' },
            t = { '<Cmd>ZkNewFromTitleSelection<CR>', mode = 'v', 'New note from title selection' },
            T = { '<Cmd>ZkTags<CR>', 'Tags' },
            v = { '<Cmd>ZkNewFromContentSelection<CR>', mode = 'v', 'New note from content selection' },
        },
    },
    ['<C-w>'] = {
        ['<C-m>'] = { '<Cmd>WinShift<CR>', 'Move window mode' },
        m = { '<Cmd>WinShift<CR>', 'Move window mode' },
        x = { '<Cmd>WinShift swap<CR>' },
        g = {
            name = '+move window',
            h = { '<Cmd>WinShift left<CR>', 'Move left' },
            j = { '<Cmd>WinShift down<CR>', 'Move down' },
            k = { '<Cmd>WinShift up<CR>', 'Move up' },
            l = { '<Cmd>WinShift right<CR>', 'Move right' },
        },
        p = {
            function()
                local winid = require('winpick').select()
                if winid then
                    vim.api.nvim_set_current_win(winid)
                end
            end, 'Pick a window' }
    },
})

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
-- windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
-- buffers
vim.keymap.set('n', 'gB', '<Cmd>bp<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gb', '<Cmd>bn<CR>', { noremap = true, silent = true })
-- quickfix
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[q', '<Cmd>cprev<CR>', { noremap = true, silent = true })
-- todo comments
vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { noremap = true, silent = true })
vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { noremap = true, silent = true })
-- jest
vim.cmd [[nnoremap <silent> [j ?^\s\+\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\)\><CR>]]
vim.cmd [[nnoremap <silent> ]j /^\s\+\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\)\><CR>]]

--
-- edit
--
-- insert blank lines
-- TODO: rewrite to lua mapping
vim.cmd [[nnoremap gO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[]]
vim.cmd [[nnoremap go  :<c-u>put =repeat(nr2char(10), v:count1)<cr>]]

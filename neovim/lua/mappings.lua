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

wk.register({
    ["<Leader>"] = {
        f = {
            name = '+find',
            f = { telescope_builtin.find_files, 'Find files' },
            h = { '<Cmd>Telescope find_files hidden=true<CR>', 'Hidden files' },
            o = { telescope_builtin.oldfiles, 'Open recent files' },
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
            k = { '<Plug>MarkSet', 'Set mark', mode = { 'n', 'x' } },
            c = { '<Plug>MarkClear', 'Clear mark', mode = { 'n', 'x' } },
            m = { '<Plug>MarkToggle', 'Toggle mark', mode = { 'n', 'x' } },
            l = { 'V:<C-u>HSHighlight 1<CR>', 'Highlight line', mode = { 'n', 'x' } },
            r = { 'V:<C-u>HSHighlight 4<CR>', 'Highlight line red', mode = { 'n', 'x' } },
            g = { 'V:<C-u>HSHighlight 5<CR>', 'Highlight line green', mode = { 'n', 'x' } },
            x = { 'V:<C-u>HSRmHighlight<CR>', 'Remove highlight', mode = { 'n', 'x' } },
        },
        n = {
            name = '+neo-tree',
            c = { ':Neotree left filesystem toggle reveal_file=<cfile><CR>', 'Show file under cursor' },
            d = { ':Neotree left filesystem toggle dir=', 'Open dir', silent=false },
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
            -- h = { telescope_builtin., 'Live grep' },
            l = { telescope_builtin.live_grep, 'Live grep' },
            L = { require("telescope").extensions.live_grep_args.live_grep_args, 'Live grep args' },
            r = { telescope_builtin.resume, 'Resume' },
            z = { telescope_builtin.current_buffer_fuzzy_find, 'Current buffer fuzzy find' },

        },
        w = {
            name = '+workbench +vimwiki',
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
        p = 'Pick a window',
    },
})

-- lsp
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ wrap = false }) end, { noremap = true, silent = true })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ wrap = false }) end, { noremap = true, silent = true })
vim.keymap.set('n', '\\c', '/\\c', { noremap = true, silent = false, desc = 'Case insensitive search' })
vim.keymap.set('n', '\\s', '/\\<\\><left><left>',
    { noremap = true, silent = false, desc = 'Search for word (like grep -w)' })

-- make n/N always go in the same direction
vim.keymap.set('n', 'n', "(v:searchforward ? 'n' : 'N')", { noremap = true, silent = true, expr = true })
vim.keymap.set('n', 'N', "(v:searchforward ? 'N' : 'n')", { noremap = true, silent = true, expr = true })

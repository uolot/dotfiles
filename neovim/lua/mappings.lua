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
        x = {
            name = "+toggles",
            b = { function() vim_opt_toggle('background', 'light', 'dark') end, "Background" },
            d = { toggle_diagnostic, "Diagnostics" },
            i = { function() vim.lsp.buf.inlay_hint(0) end, "Inlay hints" },
            r = { function() vim_opt_toggle('relativenumber', true, false) end, "Relative number" },
            w = { function() vim_opt_toggle('wrap', true, false) end, "Line wrap" },
        },
        g = {
            name = '+lsp',
            a = { '<Cmd>CodeActionMenu<CR>', 'Code Action' },
            e = { vim.diagnostic.open_float, 'Show current line diagnostics' },
            d = { vim.lsp.buf.definition, 'Go to definition' },
            D = { vim.lsp.buf.declaration, 'Go to declaration' },
            f = { function() telescope_builtin.lsp_references({ fname_width = 50 }) end, 'Find references' },
            h = { vim.lsp.buf.hover, 'Hover' },
            I = { vim.lsp.buf.implementation, 'Go to implementation' },
            i = { telescope_builtin.lsp_incoming_calls, 'Incoming calls' },
            o = { telescope_builtin.lsp_outgoing_calls, 'Outgoing calls' },
            -- r = { vim.lsp.buf.rename, 'Rename' },
            r = { '<Cmd>IncRename <C-r><C-w>', 'Rename' },
            s = { telescope_builtin.lsp_document_symbols, 'Document symbols' },
            S = { telescope_builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols' },
            t = { vim.lsp.buf.type_definition, 'Go to type definition' },
            u = { vim.lsp.buf.references, 'Go to references' },
            w = {
                name = '+Workspace',
                a = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
                r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
                l = { vim.lsp.buf.list_workspace_folders, 'List workspace folders' },
            },
            x = { '<Cmd>TroubleToggle document_diagnostics<CR>', 'Trouble document diagnostics' },
            X = { '<Cmd>TroubleToggle workspace_diagnostics<CR>', 'Trouble workspace diagnostics' },
        },
    }
})

-- lsp
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ wrap = false }) end, { noremap = true, silent = true })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ wrap = false }) end, { noremap = true, silent = true })

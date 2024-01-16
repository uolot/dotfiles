local telescope_builtin = require('telescope.builtin')

return {
    name = '+lsp',
    -- TODO: remove if actions-preview works well
    A = { '<Cmd>CodeActionMenu<CR>', 'Code Action', mode = { 'n', 'x' } },
    a = { require('actions-preview').code_actions, 'Code Action', mode = { 'n', 'v', 'x' } },
    e = { vim.diagnostic.open_float, 'Show current line diagnostics' },
    d = {
        function()
            if vim.bo.filetype == 'typescript' then
                vim.cmd('TSToolsGoToSourceDefinition')
            else
                vim.lsp.buf.definition()
            end
        end,
        'Go to definition',
    },
    D = { vim.lsp.buf.declaration, 'Go to declaration' },
    -- f = { function() telescope_builtin.lsp_references({ fname_width = 50 }) end, 'Find references' },
    -- f = { function() telescope_builtin.lsp_references() end, 'Find references' },
    f = { function() telescope_builtin.lsp_references({ fname_width = 70, trim_text = true }) end,
        'Find references' },
    -- f = { function() telescope_builtin.lsp_references({ show_line = false }) end, 'Find references' },
    h = { vim.lsp.buf.hover, 'Hover' },
    i = { telescope_builtin.lsp_incoming_calls, 'Incoming calls' },
    I = { '<Cmd>Telescope import<CR>', 'Import' },
    m = { vim.lsp.buf.implementation, 'Go to implementation' },
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
}

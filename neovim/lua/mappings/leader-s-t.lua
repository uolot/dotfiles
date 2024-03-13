local function get_ts_tree(node, tree)
    if not tree then tree = '' end
    if not node then node = vim.treesitter.get_node() end
    if not node then return tree end

    if #tree > 0 then
        tree = node:type() .. ' > ' .. tree
    else
        tree = node:type()
    end

    if node:parent() then
        return get_ts_tree(node:parent(), tree)
    else
        return tree
    end
end

return {
    name = '+typescript',
    -- e = { require('better-ts-errors').toggle, 'Better TS errors' },
    i = {
        name = '+imports',
        a = { '<Cmd>TSToolsAddMissingImports<CR>', 'Add missing imports' },
        o = { '<Cmd>TSToolsOrganizeImports<CR>', 'Organize imports' },
        s = { '<Cmd>TSToolsSortImports<CR>', 'Sort imports' },
        r = { '<Cmd>TSToolsRemoveUnusedImports<CR>', 'Remove unused imports' },
    },
    f = { '<Cmd>TSToolsFileReferences<CR>', 'File references' },
    r = { '<Cmd>TSToolsRenameFile<CR>', 'Rename file' },
    s = { '<Cmd>TSToolsGoToSourceDefinition<CR>', 'Go to source definition' },
    t = { function() print(get_ts_tree()) end, 'Show current TS node' },
    u = { '<Cmd>TSToolsRemoveUnused<CR>', 'Remove unused' },
    x = { '<Cmd>TSToolsFixAll<CR>', 'Fix all' },
}

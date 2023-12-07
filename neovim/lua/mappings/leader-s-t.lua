return {
    name = '+typescript',
    d = { '<Cmd>TSToolsGoToSourceDefinition<CR>', 'Go to source definition' },
    i = {
        name = '+imports',
        a = { '<Cmd>TSToolsAddMissingImports<CR>', 'Add missing imports' },
        o = { '<Cmd>TSToolsOrganizeImports<CR>', 'Organize imports' },
        s = { '<Cmd>TSToolsSortImports<CR>', 'Sort imports' },
        r = { '<Cmd>TSToolsRemoveUnusedImports<CR>', 'Remove unused imports' },
    },
    f = { '<Cmd>TSToolsFileReferences<CR>', 'File references' },
    r = { '<Cmd>TSToolsRenameFile<CR>', 'Rename file' },
    u = { '<Cmd>TSToolsRemoveUnused<CR>', 'Remove unused' },
    x = { '<Cmd>TSToolsFixAll<CR>', 'Fix all' },

}

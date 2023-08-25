return {
    name = '+zk',
    c = {
        function() vim.ui.input({ prompt = "Title: " }, function(i) vim.cmd('ZkNew {title="' .. i .. '"}') end) end,
        'Create new note' },
    b = { '<Cmd>ZkBacklinks<CR>', 'Backlinks' },
    f = { '<Cmd>ZkNotes<CR>', 'Find a note' },
    i = { '<Cmd>ZkInsertLink<CR>', 'Insert link' },
    l = { '<Cmd>ZkLinks<CR>', 'Links' },
    s = { '<Cmd>ZkNewFromTitleSelection<CR>', mode = 'v', 'New note from title selection' },
    t = { '<Cmd>ZkTags<CR>', 'Tags' },
    v = { '<Cmd>ZkNewFromContentSelection<CR>', mode = 'v', 'New note from content selection' },
}

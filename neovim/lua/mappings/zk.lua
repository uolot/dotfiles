return {
    name = '+zk',
    c = {
        function() vim.ui.input({ prompt = "Title: " }, function(i) vim.cmd('ZkNew {title="' .. i .. '"}') end) end,
        'New note' },
    b = { '<Cmd>ZkBackLinks<CR>', 'Backlinks' },
    f = { '<Cmd>ZkNotes<CR>', 'Find a note' },
    i = { '<Cmd>ZkInsertLink<CR>', 'Insert link' },
    l = { '<Cmd>ZkLinks<CR>', 'Links' },
    t = { '<Cmd>ZkNewFromTitleSelection<CR>', mode = 'v', 'New note from title selection' },
    T = { '<Cmd>ZkTags<CR>', 'Tags' },
    v = { '<Cmd>ZkNewFromContentSelection<CR>', mode = 'v', 'New note from content selection' },
}

return {
    name = '+marks',
    c = { '<Plug>MarkClear', 'Clear mark', mode = { 'n', 'x' } },
    g = { 'V:<C-u>HSHighlight 5<CR>', 'Highlight line green', mode = { 'n', 'x' } },
    k = { '<Plug>MarkSet', 'Set mark', mode = { 'n', 'x' } },
    l = { 'V:<C-u>HSHighlight 1<CR>', 'Highlight line', mode = { 'n', 'x' } },
    m = { '<Plug>MarkToggle', 'Toggle mark', mode = { 'n', 'x' } },
    r = { 'V:<C-u>HSHighlight 4<CR>', 'Highlight line red', mode = { 'n', 'x' } },
    x = { 'V:<C-u>HSRmHighlight<CR>', 'Remove highlight', mode = { 'n', 'x' } },
}

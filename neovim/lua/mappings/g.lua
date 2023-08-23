return {
    B = { '<Cmd>bp', 'Previous buffer', silent = true },
    b = { '<Cmd>bn', 'Next buffer', silent = true },
    O = { ':<C-u>put! =repeat(nr2char(10), v:count1)<CR>', 'Insert blank lines above' },
    o = { ':<C-u>put =repeat(nr2char(10), v:count1)<CR>', 'Insert blank lines below' },
    V = { '`[v`]', 'Select inserted/pasted text', mode = 'v' },
}

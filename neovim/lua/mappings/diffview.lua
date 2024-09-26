return {
    name = '+diffview',
    c = { '<Cmd>DiffviewClose<CR>', 'Close' },
    h = { '<Cmd>DiffviewFileHistory %<CR>', 'File history' },
    o = { '<Cmd>DiffviewOpen<CR>', 'Open' },
    t = { require("dapui").toggle, 'Toggle DAP UI' },
    f = { require("dapui").float_element, 'Open DAP UI float' },
    e = { require("dapui").eval, 'Evaluate expression with DAP UI' },

}

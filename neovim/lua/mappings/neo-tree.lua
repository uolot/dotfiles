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
    name = '+neo-tree',
    c = { ':Neotree left filesystem toggle reveal_file=<cfile><CR>', 'Show file under cursor' },
    d = { ':Neotree left filesystem toggle dir=', 'Open dir', silent = false },
    f = { ':Neotree left filesystem toggle reveal<CR>', 'Show current file' },
    n = { ':Neotree left filesystem toggle<CR>', 'Toggle' },
    -- t = { function () print(vim.treesitter.get_node():type()) end, 'Show current TS node' },
    t = { function () print(get_ts_tree()) end, 'Show current TS node' },
}

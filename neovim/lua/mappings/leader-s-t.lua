local wk = require("which-key")

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

wk.add({
    mode = "n",
    { "<Leader>T",  group = "Typescript" },
    { "<Leader>Tm", '<Cmd>VtsExec add_missing_imports<CR>',     desc = 'Add missing imports' },
    { "<Leader>To", '<Cmd>VtsExec organize_imports<CR>',        desc = 'Organize imports' },
    { "<Leader>Ts", '<Cmd>VtsExec go_to_source_definition<CR>', desc = 'Go to source definition' },
    { "<Leader>Tt", function() print(get_ts_tree()) end,        desc = 'Show current TS node' },
})

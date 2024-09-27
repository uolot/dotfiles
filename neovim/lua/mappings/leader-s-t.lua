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
    { "<Leader>T",   group = "Typescript" },
    { "<Leader>Tf",  '<Cmd>TSToolsFileReferences<CR>',       desc = 'File references' },
    { "<Leader>Tr",  '<Cmd>TSToolsRenameFile<CR>',           desc = 'Rename file' },
    { "<Leader>Ts",  '<Cmd>TSToolsGoToSourceDefinition<CR>', desc = 'Go to source definition' },
    { "<Leader>Tt",  function() print(get_ts_tree()) end,    desc = 'Show current TS node' },
    { "<Leader>Tu",  '<Cmd>TSToolsRemoveUnused<CR>',         desc = 'Remove unused' },
    { "<Leader>Tx",  '<Cmd>TSToolsFixAll<CR>',               desc = 'Fix all' },
    -- imports
    { "<Leader>Ti",  group = 'Imports' },
    { "<Leader>Tia", '<Cmd>TSToolsAddMissingImports<CR>',    desc = 'Add missing imports' },
    { "<Leader>Tio", '<Cmd>TSToolsOrganizeImports<CR>',      desc = 'Organize imports' },
    { "<Leader>Tis", '<Cmd>TSToolsSortImports<CR>',          desc = 'Sort imports' },
    { "<Leader>Tir", '<Cmd>TSToolsRemoveUnusedImports<CR>',  desc = 'Remove unused imports' },
})

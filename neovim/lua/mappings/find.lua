local telescope_builtin = require('telescope.builtin')

return {
    name = '+find',
    f = { telescope_builtin.find_files, 'Find files' },
    g = { telescope_builtin.git_status, 'Git status' },
    h = { '<Cmd>Telescope find_files hidden=true<CR>', 'Hidden files' },
    o = { telescope_builtin.oldfiles, 'Open recent files' },
    p = {
        function()
            local fname = vim.api.nvim_buf_get_name(0)
            local git_root = require('lspconfig.util').find_git_ancestor(fname)
            telescope_builtin.find_files({ cwd = git_root })
        end,
        'Find files in git root',
    },
}

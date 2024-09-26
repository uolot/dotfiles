local telescope_builtin = require('telescope.builtin')
local mini_files = require('mini.files')

return {
    name = '+find',
    c = { function()
        local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
        if not mini_files.close() then mini_files.open(path, false) end
    end, 'Mini files - current file' },
    f = { telescope_builtin.find_files, 'Find files' },
    g = { telescope_builtin.git_status, 'Git status' },
    h = { '<Cmd>Telescope find_files hidden=true<CR>', 'Hidden files' },
    m = {
        -- mini_files.open,
        function()
            if not mini_files.close() then mini_files.open() end
        end,
        'Mini files',
    },
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

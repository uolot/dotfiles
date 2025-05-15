local opts = {
    -- _inline2 = true,
    signcolumn = true,
    numhl = true,
    linehl = false,
    word_diff = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
    },
    preview_config = {
        style = 'minimal',
        relative = 'cursor',
        row = 1,
        col = 1,
    },
    on_attach = function(bufnr)
        -- TODO: move remaining mappings to mappings.gitsigns

        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
            -- opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            -- vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']h', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[h', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

return { opts = opts }

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
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 1,
        col = 1,
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
            -- opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            -- vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        -- map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
        -- map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        -- normal
        -- map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=false}<CR>')
        map('n', '<leader>hb', function() gs.blame_line({ full = false }) end)
        map('n', '<leader>hB', function() gs.blame_line({ full = true }) end)
        -- map('n', '<leader>hi', '<cmd>Gitsigns preview_hunk_inline<CR>')
        map('n', '<leader>hi', gs.preview_hunk_inline)
        map('n', '<leader>hl', gs.setloclist)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hs', gs.stage_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hq', gs.setqflist)
        map('n', '<leader>htb', gs.toggle_current_line_blame)
        map('n', '<leader>htd', gs.toggle_deleted)
        map('n', '<leader>htl', gs.toggle_linehl)
        map('n', '<leader>htw', gs.toggle_word_diff)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        -- visual
        -- map('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        -- map('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')

        -- Text object
        map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

return { opts = opts }

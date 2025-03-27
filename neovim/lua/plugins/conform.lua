local opts = {
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        json = { "prettierd" },
        jsonc = { "prettierd" },
        markdown = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
    },
}

local init = function()
    -- format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
                return
            end

            require("conform").format({ bufnr = args.buf })

            local filetype = vim.bo[args.buf].filetype
            if filetype == "typescript" or filetype == "typescriptreact" then
                pcall(function()
                    vim.cmd('TSToolsAddMissingImports sync')
                    vim.cmd('TSToolsOrganizeImports sync')
                end)
            end
        end,
    })

    -- :Format command
    vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
                start = { args.line1, 0 },
                ["end"] = { args.line2, end_line:len() },
            }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })

    -- :FormatDisable command
    vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
            -- FormatDisable! will disable formatting for all buffers
            vim.g.disable_autoformat = true
        else
            vim.b.disable_autoformat = true
        end
    end, {
        desc = "Disable autoformat-on-save",
        bang = true,
    })

    -- :FormatEnable command
    vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
    end, {
        desc = "Re-enable autoformat-on-save",
    })
end

return {
    opts = opts,
    init = init,
}

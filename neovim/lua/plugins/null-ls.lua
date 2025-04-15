-- Docs:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local function config()
    local null_ls = require("null-ls")
    local shellcheck = require("none-ls-shellcheck")

    null_ls.setup({
        sources = {
            -- typescript
            -- null_ls.builtins.code_actions.eslint_d,
            -- null_ls.builtins.diagnostics.eslint_d,
            -- null_ls.builtins.code_actions.eslint, -- TODO: deprecated
            -- null_ls.builtins.diagnostics.eslint,  -- TODO: deprecated
            -- null_ls.builtins.code_actions.eslint, -- from none-ls-extras
            -- null_ls.builtins.diagnostics.eslint,  -- from none-ls-extras

            -- python
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.mypy,
            -- null_ls.builtins.diagnostics.flake8,

            -- shell
            -- null_ls.builtins.code_actions.shellcheck, -- TODO: deprecated
            shellcheck.code_actions,
            shellcheck.diagnostics,

            -- github actions
            null_ls.builtins.diagnostics.actionlint,

            -- cloudformation
            null_ls.builtins.diagnostics.cfn_lint,

            -- sql
            -- FIXME:
            -- null_ls.builtins.formatting.sqlformat,

            -- xml
            -- null_ls.builtins.formatting.xmlformat, -- TODO: deprecated

            -- spelling
            -- null_ls.builtins.diagnostics.typos.with({
            --     extra_args = { '--config', os.getenv('HOME') .. '/.dotfiles/typos/typos.toml' },
            -- }), -- TODO: deprecated

            -- misc
            null_ls.builtins.diagnostics.trail_space.with({
                disabled_filetypes = { 'git', 'gitcommit', 'NvimTree', 'markdown', 'dbout' } }),
        },
        border = 'rounded', -- TODO: remove?
        diagnostics_format = "#{s}: #{m} (#{c})"
    })
end

return { config = config }

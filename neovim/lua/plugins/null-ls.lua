-- Docs:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local function config()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            -- typescript
            -- null_ls.builtins.code_actions.eslint_d,
            -- null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.diagnostics.eslint,

            -- python
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.mypy,
            -- null_ls.builtins.diagnostics.flake8,

            -- shell
            null_ls.builtins.code_actions.shellcheck,

            -- github actions
            null_ls.builtins.diagnostics.actionlint,

            -- cloudformation
            null_ls.builtins.diagnostics.cfn_lint,

            -- xml
            null_ls.builtins.formatting.xmlformat,

            -- spelling
            null_ls.builtins.diagnostics.typos.with({
                extra_args = { '--config', os.getenv('HOME') .. '/.dotfiles/typos/typos.toml' },
            }),

            -- misc
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.diagnostics.trail_space.with({
                disabled_filetypes = { 'git', 'gitcommit', 'NvimTree', 'markdown', 'dbout' } }),
        },
        border = 'rounded',
        diagnostics_format = "#{s}: #{m} (#{c})"
    })
end

return { config = config }

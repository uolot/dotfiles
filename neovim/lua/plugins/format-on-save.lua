local config = function()
  local format_on_save = require("format-on-save")
  local formatters = require("format-on-save.formatters")

  local function formatTS()
    pcall(function()
      vim.cmd('TSToolsAddMissingImports sync')
      vim.cmd('TSToolsOrganizeImports sync')
    end)

    format_on_save.format()
    format_on_save.restore_cursors()

    vim.cmd('normal zz')
  end

  vim.api.nvim_create_augroup('Format', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    -- pattern = '{*}{*.ts}\\@<!',
    group = 'Format',
    callback = function(args)
      if vim.g.started_by_firenvim then
        return
      end

      if vim.regex('\\.ts$'):match_str(args.file) then
        formatTS()
      else
        format_on_save.format()
        format_on_save.restore_cursors()
      end
    end
  })

  format_on_save.setup({
    auto_commands = false,
    user_commands = false,

    exclude_path_patterns = {
      "/node_modules/",
      ".local/share/nvim/lazy",
    },

    -- error_notifier = {
    --   show = function(opts)
    --     require("notify")(opts.body, "error", { title = opts.title })
    --   end,
    --   hide = function()
    --     -- noop
    --   end,
    -- },

    -- experiments = {
    --   partial_update = "diff",
    -- },

    formatter_by_ft = {
      astro = {
        formatters.lsp,
      },
      bash = {
        formatters.lsp,
        formatters.shfmt,
      },
      css = formatters.lsp,
      html = formatters.lsp,
      java = formatters.lsp,
      go = { -- Use a tempfile instead of stdin
        formatters.shell({
          cmd = { "goimports-reviser", "-rm-unused", "-set-alias", "-format", "%" },
          tempfile = function()
            return vim.fn.expand("%") .. ".formatter-temp"
          end,
        }),
        formatters.shell({ cmd = { "gofmt" } }),
      },
      javascript = {
        formatters.eslint_d_fix,
        formatters.prettierd,
        -- formatters.if_file_exists({
        --     pattern = ".eslintrc.*",
        --     formatter = formatters.eslint_d_fix,
        -- }),
        -- formatters.if_file_exists({
        --     pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
        --     formatter = formatters.prettierd,
        -- }),
      },
      json = {
        -- formatters.lsp,
        formatters.prettierd,
      },
      lua = formatters.lsp,
      markdown = formatters.prettierd,
      python = {
        formatters.remove_trailing_whitespace,
        -- formatters.shell({ cmd = "tidy-imports" }),
        formatters.black,
        -- formatters.ruff,
      },
      query = formatters.lsp,
      rust = formatters.lsp,
      scheme = formatters.lsp,
      scss = formatters.lsp,
      sh = {
        formatters.lsp,
        formatters.shfmt,
      },
      -- FIXME:
      -- sql = formatters.lsp,
      terraform = formatters.lsp,
      typescript = {
        -- formatters.lsp,
        -- formatters.eslint_d_fix,
        formatters.prettierd,
        -- formatters.if_file_exists({
        --     pattern = { ".eslintrc.*" },
        --     formatter = formatters.eslint_d_fix,
        -- }),
        -- formatters.if_file_exists({
        --     pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
        --     formatter = formatters.prettierd,
        -- }),
      },
      typescriptreact = formatters.prettierd,
      xml = formatters.lsp,
      yaml = {
        formatters.prettierd,
        formatters.lsp,
      },

      -- Add your own shell formatters:
      -- myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }),

      -- Add lazy formatter that will only run when formatting:
      -- my_custom_formatter = function()
      --     if vim.api.nvim_buf_get_name(0):match("/README.md$") then
      --         return formatters.prettierd
      --     else
      --         return formatters.lsp()
      --     end
      -- end,

      -- Add custom formatter
      -- filetype1 = formatters.remove_trailing_whitespace,
      -- filetype2 = formatters.custom({
      --     format = function(lines)
      --         return vim.tbl_map(function(line)
      --             return line:gsub("true", "false")
      --         end, lines)
      --     end
      -- }),
    },

    -- Optional: fallback formatter to use when no formatters match the current filetype
    fallback_formatter = {
      -- formatters.remove_trailing_whitespace,
      -- formatters.prettierd,
    },

    -- By default, all shell commands are prefixed with "sh -c" (see PR #3)
    -- To prevent that set `run_with_sh` to `false`.
    run_with_sh = true,
  })
end

return { config = config }

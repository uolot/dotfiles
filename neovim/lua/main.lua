require('plugins')

require('impatient')
vim.loader.enable()

-- needs setup before LSP
-- require('neodev').setup({})

-- LSP --

-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')

local on_lsp_attach = function(client, buffer)
    -- ufo
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- -- local capabilities = requite('cmp_nvim_lsp').default_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --     dynamicRegistration = false,
    --     lineFoldingOnly = true,
    -- }
    -- client.capabilities = capabilities
    -- ufo end

    -- TODO: update capabilities with `require('cmp_nvim_lsp').update_capabilities
    if client.supports_method('textDocument/formatting') then
        require('lsp-zero').buffer_autoformat()
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(buffer, false)
    end
end

-- TODO: remove
local on_tsserver_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- if client.server_capabilities.inlayHintProvider then
    --     vim.lsp.buf.inlay_hint(bufnr, false)
    -- end

    -- on_lsp_attach(client, bufnr)
end

-- jose-elias-alvarez/null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
null_ls.setup({
    sources = {
        -- typescript
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettierd,
        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.flake8,
        -- misc
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.trail_space.with({
            disabled_filetypes = { 'git', 'gitcommit', 'NvimTree', 'markdown' } }),
        null_ls.builtins.formatting.xmlformat,
    },
    on_attach = on_lsp_attach,
})

local lsputils_border_chars = {
    TOP_LEFT = '┌',
    TOP_RIGHT = '┐',
    MID_HORIZONTAL = '─',
    MID_VERTICAL = '│',
    BOTTOM_LEFT = '└',
    BOTTOM_RIGHT = '┘',
}

vim.g.lsp_utils_location_opts = {
    preview = {
        border = true,
        border_chars = lsputils_border_chars,
    }
}

vim.g.lsp_utils_symbols_opts = {
    preview = {
        border = true,
        border_chars = lsputils_border_chars,
    }
}

vim.g.lsp_utils_codeaction_opts = {
    preview = {
        border = true,
        border_chars = lsputils_border_chars,
    }
}

-- LSP borders
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = 'rounded'
    }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "rounded"
    }
)

-- nvim-lsp-installer
-- https://github.com/williamboman/nvim-lsp-installer#setup
local function filter(arr, fn)
    if type(arr) ~= "table" then
        return arr
    end

    local filtered = {}
    for k, v in pairs(arr) do
        if fn(v, k, arr) then
            table.insert(filtered, v)
        end
    end

    return filtered
end

local function filterDTS(value)
    return string.match(value.uri, '%.d.ts') == nil
    -- return string.match(value.targetUri, '%.d.ts') == nil
end

-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.on_server_ready(function(server)
--     local opts = {
--         on_attach = on_lsp_attach,
--         flags = {
--             -- This will be the default in neovim 0.7+
--             debounce_text_changes = 150,
--         },
--     }
--
--     local signs = { Hint = "", Info = "", Warn = "", Error = "" }
--     for type, icon in pairs(signs) do
--         local hl = "DiagnosticSign" .. type
--         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--     end
--
--     if server.name == "tsserver" then
--         opts.on_attach = on_tsserver_attach
--         -- opts.on_attach = on_lsp_attach
--         -- opts.handlers = {
--         --     ["textDocument/definition"] = function (error, result, method, ...)
--         --         -- if not vim.tbl_islist(result) or type(result) ~= "table" then
--         --         --     return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
--         --         -- end
--         --         --
--         --         -- return vim.lsp.handlers["textDocument/definition"](err, { result[1] }, method, ...)
--         --
--         --         -- vim.notify(vim.inspect(result))
--         --         if (vim.tbl_islist(result) or type(result) == "table") and #result > 1 then
--         --             local filtered_result = filter(result, filterDTS)
--         --             -- vim.notify(vim.inspect(filtered_result))
--         --             return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
--         --         end
--         --
--         --         return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
--         --     end
--         -- }
--     end
--
--     server:setup(opts)
-- end)

-- local lspconfig = require('lspconfig')
-- lspconfig.tsserver.setup { on_attach = on_attach }
--
require("null-ls").setup()
require("mason-null-ls").setup({
    --     -- ensure_installed = {"prettier", "eslint-lsp"},
    automatic_installation = true,
    --     automatic_setup = true,
})

require("mason").setup()

require("mason-lspconfig").setup({
    -- ensure_installed = {
    --     'tsserver',
    --     'eslint',
    --     -- 'prettier',
    -- }
})

local lsp = require('lsp-zero')
-- lsp.set_sign_icons()
lsp.extend_lspconfig({
    set_lsp_keymaps = false,
    on_attach = on_lsp_attach,
    capabilities = {
        textDocument = {
            foldingRange = { -- ufo
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
        }
    }
})
-- local lsp = require('lsp-zero').preset({})
-- lsp.on_attach(function(client, bufnr)
--   -- lsp.default_keymaps({buffer = bufnr})
-- end)
-- lsp.setup()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            -- on_attach = on_lsp_attach
        })
    end,
    ['tsserver'] = function()
        lspconfig.tsserver.setup({
            on_attach = on_tsserver_attach,
            settings = {
                completions = {
                    -- completeFunctionCalls = true
                },
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                }
            }
        })
    end
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
}

-- adjust virtual text severity
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- signs = {
        --     severity_limit = 'Warning',
        -- },
        virtual_text = {
            severity_limit = 'Warning',
        },
    }
)

-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
vim.diagnostic.config({
    -- virtual_text = false,
    virtual_text = {
        source = false,
        prefix = '●',
        spacing = 1,
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = true,
        -- source = false,
    },
    signs = true,
    -- virtual_lines = false,
})

-- smjonas/inc-rename.nvim
require('inc_rename').setup()


-- Completion --

-- onsails/lspkind-nvim
local lspkind = require('lspkind')

-- nvim-cmp

local cmp = require('cmp')

require('copilot').setup({
    -- suggestion = { enabled = true, auto_trigger = true },
    -- panel = { enabled = true, auto_refresh = true },
    suggestion = { enabled = false },
    panel = { enabled = false },
})

require('copilot_cmp').setup()

cmp.setup({
    -- preselect = cmp.PreselectMode.None,
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    sources = {
        { name = 'nvim_lsp',                max_item_count = 12, priority = 10 },
        {
            name = 'buffer',
            max_item_count = 10,
            keyword_length = 3,
            priority = 9,
            option = {
                -- get words from other buffers
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end
            }
        },
        { name = 'copilot',                 max_item_count = 10, keyword_length = 1, priority = 8 },
        -- { name = 'cmp_tabnine', max_item_count = 3, priority = 8 },
        { name = 'nvim_lsp_signature_help', priority = 7 },
        { name = 'vsnip',                   max_item_count = 3,  keyword_length = 2, priority = 5 },
        { name = 'path',                    max_item_count = 3,  priority = 5,       option = { trailing_slash = false } },
        -- { name = 'omni', max_item_count = 5, priority = 4 },
        { name = 'calc',                    max_item_count = 3,  priority = 2 },
        { name = 'emoji',                   max_item_count = 3,  priority = 2,       option = { insert = true } },
    },
    performance = {
        max_view_options = 20,
    },
    mapping = cmp.mapping.preset.insert({
        -- ['<C-b>'] = function(fallback)
        ['<C-k>'] = function(fallback)
            if cmp.visible() then
                cmp.mapping.scroll_docs(-1)
            else
                fallback()
            end
        end,
        -- ['<C-f>'] = function(fallback)
        ['<C-j>'] = function(fallback)
            if cmp.visible() then
                cmp.mapping.scroll_docs(1)
            else
                fallback()
            end
        end,
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.abort(),
        ['<C-CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'text_symbol',
            maxwidth = 50,
            -- preset = "default",
            menu = ({
                buffer = "[Buf]",
                calc = "[Calc]",
                -- cmp_tabnine = "[TN]",
                copilot = "[Copilot]",
                emoji = "[Emoji]",
                nvim_lsp = "[LSP]",
                nvim_lsp_document_symbol = "[DocSym]",
                nvim_lsp_signature_help = "[Sig]",
                omni = "[Omni]",
                path = "[Path]",
                vsnip = "[VSnip]",
            }),
            -- symbol_map = kind_icons,
        }),
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'cmdline' },
        { name = 'path' },
    }
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' },
        },
        {
            { name = 'buffer' },
        })
})
cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'nvim_lsp_document_symbol' },
        { name = 'buffer' },
    }
})

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = require('telescope.themes').get_ivy {
        mappings = {
            i = {
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
            },
        },
        file_ignore_patterns = { "tags*" },
        pickers = {
            find_files = {
                theme = "ivy",
            },
            live_grep = {
                only_sort_text = true,
            },
            lsp_references = {
                -- fname_width = 50,
                include_current_line = true,
                include_declaration = true,
            },
            tags = {
                max_results = 1000,
            },
        },
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
        },
    },
}
require('telescope').load_extension('vimwiki')
require('telescope').load_extension('zk')
require('telescope').load_extension('fzf')
require('telescope').load_extension('ag')
require('telescope').load_extension('ui-select')

-- lualine
-- https://github.com/nvim-lualine/lualine.nvim#usage-and-customization
require('lualine').setup {
    options = {
        -- theme = 'github',
        -- theme = 'auto',
        -- theme = 'nordic',
        theme = 'kanagawa',
        globalstatus = false,
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
            {
                'fileformat',
                icons_enabled = true,
                symbols = {
                    unix = '',
                    dos = ' CRLF ',
                    mac = ' CR ',
                },
            },
        },
        lualine_c = {
            'searchcount',
            { 'diagnostics', sections = { "error", "warn" } },
        },
        -- right
        lualine_x = {
            -- 'branch',
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = { 'location', 'progress' },
    },
    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
        },
        lualine_c = {
            { 'diagnostics', sections = { "error", "warn" } },
        },
        -- right
        lualine_x = {
        },
        lualine_y = {
        },
        lualine_z = {},
    }
}

-- gitsigns
require('gitsigns').setup {
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

-- folke/which-key.nvim
-- https://github.com/folke/which-key.nvim
require("which-key").setup {
    marks = true,
    registers = true,
    spelling = {
        enabled = false,
        suggestions = 20,
    },
    presets = {
        operators = false,
        motions = false,
        text_objects = true,
        windows = true,
        nav = false,
        z = true,
        g = true,
    },
}

-- kyazdani42/nvim-tree.lua
-- https://github.com/kyazdani42/nvim-tree.lua#setup
local tree_cb = require('nvim-tree.config').nvim_tree_callback
require('nvim-tree').setup {
    disable_netrw = false,
    hijack_netrw = true,
    -- open_on_setup = false,
    -- ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = false,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 100,
    },
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    renderer = {
        icons = {
            git_placement = "after",
        },
        add_trailing = true,
        highlight_opened_files = "all",
    },
    git = {
        ignore = true,
    },
    view = {
        width = 30,
        hide_root_folder = false,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {
                { key = "<C-s>", cb = tree_cb("split") },
            },
        },
    },
}

-- 'chentau/marks.nvim'
-- https://github.com/chentoast/marks.nvim#setup
require 'marks'.setup {
    -- whether to map keybinds or not. default true
    default_mappings = false,
    -- which builtin marks to show. default {}
    -- builtin_marks = { ".", "<", ">", "^" },
    builtin_marks = {},
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    mappings = {}
}

-- diagrams
-- require('./lua/venn-mappings.lua')
-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd [[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "v", "d", ":VBoxD<CR>", { noremap = true })
    else
        vim.cmd [[setlocal ve=]]
        vim.cmd [[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>vv', ":lua Toggle_venn()<CR>", { noremap = true })

-- https://github.com/sindrets/winshift.nvim#configuration
require("winshift").setup({
    highlight_moving_win = true,
});

-- https://github.com/gbrlsnchs/winpick.nvim#setup
require('winpick').setup({
    border = 'rounded',
})

vim.keymap.set('n', '<C-w>p', function()
    local winid = require('winpick').select()
    if winid then
        vim.api.nvim_set_current_win(winid)
    end
end);

-- vim.o.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T@v:lua.ScNa@%=%{v:lua.ScLn()}%T"

local scb = require("statuscol.builtin")
require("statuscol").setup({
    -- foldfunc = "builtin",
    setopt = true,
    relculright = true,
    segments = {
        { text = { scb.foldfunc }, click = "v:lua.ScFa" },
        { text = { scb.lnumfunc }, click = "v:lua.ScLa", },
        { text = { " %s" },        click = "v:lua.ScSa" },
    }
})

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#444444 gui=nocombine]]
-- -- vim.cmd [[highlight IndentBlanklineContextChar guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#909090 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=#909090 gui=underline]]

require('indent_blankline').setup({
    use_treesitter = true,
    space_char_blankline = " ",
    -- char_list = {'│', '¦'},
    char = '│',
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = false,
    char_highlight_list = {
        "IndentBlanklineIndent1",
    },
    buftype_exclude = { "terminal", "nofile" },
    -- filetype_exclude = {},
})

local function close_floating()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        -- if config.relative == 'win' then
        if config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

require('which-key').register(
    {
        -- ["<C-w>f"] = { close_floating, "Close all floating windows"},
        ["<Esc>"] = { close_floating, "Close all floating windows" },
    },
    { mode = 'n' }
)

require('paint').setup({
    highlights = {
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*#%s+.+)",
            hl = "markdownH1",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*##%s+.+)",
            hl = "markdownH2",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*###%s+.+)",
            hl = "markdownH3",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*####%s+.+)",
            hl = "markdownH4",
        },
        {
            filter = { filetype = "markdown" },
            pattern = "^(%s*#####%s+.+)",
            hl = "markdownH5",
        },
    },
})

require('mappings')

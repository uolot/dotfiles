" ------ General settings ------

syntax on
filetype on " enables filetype detection
filetype plugin indent on " enables filetype specific plugins
let mapleader=" "

" No need to set, already a default in NeoVim:
" set autoread " reload file after changed by running a !command
" set backspace=indent,eol,start
" set nocompatible
" set hidden " hide abandoned buffers
" set hlsearch " highlight search results
" set incsearch " go to first match when typing
" set laststatus=2 " show statusline for single buffer
" set wildmenu " enable filename completion

" set breakindent
" set breakindentopt=shift:2
" set completeopt=menu,preview " show popup menu on completion with extra info
set completeopt=menu,menuone,noselect " show popup menu on completion with extra info
set completefunc=syntaxcomplete#Complete " set user-mode completions for <C-x><C-u>
" set conceallevel=2
set conceallevel=0
set cursorline " highlight cursor line
set expandtab " convert tabs to spaces
set exrc " load local .nvimrc/.exrc files
" ufo
lua vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
" lua vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
" set foldnestmax=2
set foldenable
" ufo end
set formatoptions=cq1tj " formatting - :help fo-table
set formatoptions+=ln   " new options to test
set formatoptions-=r    " unsetting, for test
set inccommand=split  " breview `:s` replace results
set lazyredraw " do not redraw screen until needed
set linebreak " do not wrap in the middle of a word
set list " display special chars
set listchars=tab:›\ ,trail:•
set nomodelineexpr  " disable modelinexpr, see: https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
" set mouse=a " enable mouse
set nrformats-=octal  " for C-a/C-x treat octal numbers (starting with 0) as decimal numbers
set number " display line numbers
set omnifunc=syntaxcomplete#Complete " enable omnicompletion
set relativenumber
set scrolloff=3 " keep lines above/below cursor line
set shiftround " round the indent spacing to the next multiple of shiftwidth
set shiftwidth=0 " use tabstop number of tabs to indent
" set showbreak=↳\  " mark wrapped lines
set showbreak=↳ " mark wrapped lines
set showcmd " show last command on bottom
set showmatch " highlight matching bracket
set splitbelow " open new horizontal splits below
set splitright " open new vertical splits on the right
set tabstop=2 " tab key inserts 4 spaces
set title  " update terminal title
set updatetime=100
set wildignorecase  " case-insensitive wild mode
set wildmode=list:longest,full
set nowrap
set nowrapscan " do not wrap to beginning of the file when searching

" setup persistent undo
let s:undodir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undodir)
    call mkdir(s:undodir, "", 0700)
endif
let &undodir=s:undodir
set undofile

" automatically equalize splits when vim is resized
autocmd VimResized * wincmd =

source $HOME/.dotfiles/neovim/plugins.vim

lua << EOF

require('impatient')
vim.loader.enable()

-- LSP --

-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')

local on_lsp_attach = function(client, buffer)
    --local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    -- if client.resolved_capabilities.document_formatting then
    -- if client.server_capabilities.documentFormattingProvider then
    if client.supports_method('textDocument/formatting') then
        -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)")

        -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({timeout_ms = 5000})")

        local augroup = vim.api.nvim_create_augroup('format_file', {clear=true})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = buffer,
            desc = 'Format',
            callback = function()
                vim.lsp.buf.format({
                    async = true,
                    timeout_ms = 5000,
                    filter = function(client) return client.name ~= 'tsserver' end,
                })
            end
        })
    end

    -- if client.server_capabilities.inlayHintProvider then
    --     vim.lsp.buf.inlay_hint(bufnr, true)
    -- end
end

-- TODO: remove
local on_tsserver_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(bufnr, true)
    end
    -- vim.lsp.buf.inlay_hint(bufnr, true)

    -- on_lsp_attach(client, bufnr)
end

-- jose-elias-alvarez/null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

require('lsp-lens').setup({
    enable = true,
    include_declaration = true,
    sections = {
        definition = true,
        references = true,
        implementation = true,
    },
})

local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
null_ls.setup({
    sources = {
        -- null_ls.builtins.code_actions.eslint,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.formatting.prettier_eslint,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.eslint.with({
        --     prefer_local = "node_modules/.bin"
        -- }),
        -- null_ls.builtins.code_actions.eslint.with({
        --     prefer_local = "node_modules/.bin"
        -- }),
        -- null_ls.builtins.diagnostics.eslint.with({
        --     prefer_local = "node_modules/.bin"
        -- }),
        -- null_ls.builtins.formatting.prettier.with({
        --     prefer_local = "node_modules/.bin",
        --     condition = function(utils)
        --         return utils.root_has_file("node_modules/.bin/prettier")
        --     end,
        --     disabled_filetypes = {"json"},
        --     -- command = "node_modules/.bin/prettier",
        -- }),
        -- null_ls.builtins.diagnostics.tsc.with({
        --     prefer_local = "node_modules/.bin",
        --     condition = function(utils)
        --         return utils.root_has_file("node_modules/.bin/tsc")
        --     end,
        -- }),
        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.flake8,
        -- misc
        -- null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = {'git', 'gitcommit', 'NvimTree', 'markdown'} }),
        -- null_ls.builtins.diagnostics.cfn_lint.with({
        --     condition = function(utils)
        --         return null_ls_helpers.args['$FILENAME'] ~= 'serverless.yml'
        --     end,
        -- }),
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

-- -- lsp_signature
-- require("lsp_signature").setup({
--     bind = true,
--     handler_opts = {
--         border = "rounded",
--     },
--     hint_enable = true,
--     hint_prefix = "",
-- })

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
    function (server_name) -- default handler (optional)
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

-- require('lsp_lines').setup()

-- require('e-kaput').setup({
--     enable = true,
--     transparency = 0,
--     borders = true,
-- })

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


-- Treesitter --
-- nvim-treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    -- ensure_installed = {
    --     "bash", "c", "clojure", "comment", "cpp", "css", "dockerfile", "dot", "go", "hcl", "html", "java", "javascript", "jsdoc", "json", "json5", "lua", "make", "python", "ruby", "rust", "toml", "tsx", "typescript", "vim", "yaml"
    -- },
    ignore_install = {}, -- List of parsers to ignore installing
    sync_install = false,
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "markdown" },
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
        -- additional_vim_regex_highlighting = { "markdown" },
    },
    indent = {
        enable = true,
        disable = {"python"},
    },
    context_commentstring = {
        enable = true
    },
    autotag = {
        enable = true,
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
        -- highlight_current_scope = { enable = true },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "<leader>gn",
            },
        },
    },
    -- rainbow = {
    --     enable = true,
    --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
    --     -- colors = {}, -- table of hex strings
    --     -- termcolors = {} -- table of colour name strings
    -- },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["al"] = "@class.outer",
                ["il"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ax"] = "@block.outer",
                ["ix"] = "@block.inner",
                ["=l"] = "@assignment.lhs",
                ["=r"] = "@assignment.rhs",
                ["i="] = "@assignment.inner",
                ["a="] = "@assignment.outer",
                ["ic"] = "@call.inner",
                ["ac"] = "@call.outer",
                ["i/"] = "@comment.outer",
                ["a/"] = "@comment.outer",
            },
            selection_modes = {
                ['@function.outer'] = 'V',
                ['@function.inner'] = 'v',
                ['@class.outer'] = 'V',
                ['@class.inner'] = 'V',
                ['@block.outer'] = 'V',
                ['@block.inner'] = 'V',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                -- ["]c"] = "@class.outer",
                -- ["]m"] = "@function.outer",
                ["]]"] = {"@class.outer", "@function.outer"},
                ["]m"] = {"@class.outer", "@function.outer"},
                -- ["]b"] = "@block.outer",
            },
            goto_previous_start = {
                -- ["[c"] = "@class.outer",
                -- ["[m"] = "@function.outer",
                ["[["] = {"@class.outer", "@function.outer"},
                ["[m"] = {"@class.outer", "@function.outer"},
                -- ["[b"] = "@block.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["]a"] = {"@parameter.inner"},
            },
            swap_previous = {
                ["[a"] = {"@parameter.inner"},
            },
        },
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = '<CR>',
            -- scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}

-- numToStr/Comment.nvim
require("Comment").setup({
    toggler = {
        line = 'gcc',
        block = 'gCC',
    },
    opleader = {
        line = 'gc',
        block = 'gC',
    },
})

--require('nvim-ts-autotag').setup()

-- Completion --

-- onsails/lspkind-nvim
local lspkind = require('lspkind')

-- nvim-cmp

-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "",
--   Interface = "",
--   Module = "",
--   Property = "ﰠ",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = ""
-- }

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
        { name = 'nvim_lsp', max_item_count = 12, priority = 10 },
        { name = 'buffer', max_item_count = 10, keyword_length = 3, priority = 9  },
        { name = 'copilot', max_item_count = 10, keyword_length = 1, priority = 8  },
        -- { name = 'cmp_tabnine', max_item_count = 3, priority = 8 },
        { name = 'nvim_lsp_signature_help', priority = 7 },
        { name = 'vsnip', max_item_count = 3, keyword_length = 2, priority = 5 },
        { name = 'path', max_item_count = 3, priority = 5, option = { trailing_slash = false } },
        -- { name = 'omni', max_item_count = 5, priority = 4 },
        { name = 'calc', max_item_count = 3, priority = 2 },
        { name = 'emoji', max_item_count = 3, priority = 2, option = {insert = true} },
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

-- require('cmp_tabnine.config'):setup({
--     max_lines = 1000,
--     max_num_results = 5,
--     sort = true,
--     run_on_every_keystroke = true,
--     snippet_placeholder = '...',
--     ignored_file_types = {
--         -- html = true,
--     },
--     show_prediction_strength = true,
-- })

-- require('tabnine').setup({
--     disable_auto_comment = true,
--     accept_keymap = '<C-j>',
--     dismiss_keymap = '<C-y>',
--     debounce_ms = 800,
--     suggestion_color = { gui = '#808080', cterm = 244 },
--     exclude_filetypes = {"TelescopePrompt"},
-- })

-- ZK
require("zk").setup({
    picker = "telescope",
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
        file_ignore_patterns = {"tags*"},
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
            require('telescope.themes').get_dropdown { }
        },
    },
}
-- require('telescope').load_extension('fzf')
require('telescope').load_extension('vimwiki')
require('telescope').load_extension('zk')
require('telescope').load_extension('fzf')
require('telescope').load_extension('ag')
require('telescope').load_extension('ui-select')

-- github colorscheme
-- https://github.com/projekt0n/github-nvim-theme#configuration
-- require('github-theme').setup {
--     options = {
--         hide_end_of_buffer = false,
--         hide_nc_statusline = false,
--         module_default = true,
--         style = {
--             comments = 'italic',
--             functions = 'NONE',
--             keywords = 'NONE',
--         },
--         darken = {
--             floats = true,
--             sidebar = true,
--         },
--     },
-- }


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
            {'diagnostics', sections={"error", "warn"} },
        },
        -- right
        lualine_x = {
            -- 'branch',
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = { 'location', 'progress'  },
    },
    inactive_sections = {
        -- left
        lualine_a = {},
        lualine_b = {
            { 'filename', path = 1, shorting_target = 40 },
        },
        lualine_c = {
            {'diagnostics', sections={"error", "warn"} },
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
        end, {expr=true})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr=true})

        -- Actions
        -- normal
        -- map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=false}<CR>')
        map('n', '<leader>hb', function() gs.blame_line({full=false}) end)
        map('n', '<leader>hB', function() gs.blame_line({full=true}) end)
        -- map('n', '<leader>hi', '<cmd>Gitsigns preview_hunk_inline<CR>')
        map('n', '<leader>hi', gs.preview_hunk_inline)
        map('n', '<leader>hl', gs.setloclist)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hr', function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hs', gs.stage_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
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

-- windwp/floatline.nvim
-- https://github.com/windwp/floatline.nvim
--require('floatline').setup()

-- trouble
require('trouble').setup {
    icons = false,
    severity = vim.diagnostic.severity.INFO,
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
tree_cb = require('nvim-tree.config').nvim_tree_callback
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

-- folke/todo-comments.nvim
-- https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
require("todo-comments").setup({
    signs = false,
    highlight = {
        multiline = false,
        -- pattern = [[.*<(KEYWORDS)\s*:]],
        pattern = [[.*<(KEYWORDS)\s*]],
        comments_only = true,
    },
    search = {
        pattern = [[\b(KEYWORDS)\b]],
    },
})

-- 'chentau/marks.nvim'
-- https://github.com/chentoast/marks.nvim#setup
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
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
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  mappings = {}
}

require('diffview').setup()

-- https://github.com/levouh/tint.nvim#gear-setup
require("tint").setup({
    tint = 15,
    tint_background_colors = true,
})

-- diagrams
-- require('./lua/venn-mappings.lua')
-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "v", "d", ":VBoxD<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>vv', ":lua Toggle_venn()<CR>", { noremap = true})

-- https://github.com/sindrets/winshift.nvim#configuration
require("winshift").setup({
    highlight_moving_win = false,
});

-- https://github.com/gbrlsnchs/winpick.nvim#setup
require('winpick').setup({
    border = 'rounded',
})

vim.keymap.set('n', '<C-w>p', function ()
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
        { text = { " %s" }, click = "v:lua.ScSa" },
    }
})

require('ufo').setup()

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
    buftype_exclude = {"terminal", "nofile"},
    -- filetype_exclude = {},
})

-- require('nvim-autopairs').setup({})

require('s3edit').setup({
    -- exclude = { ".git", ".hoodie", ".parquet", ".zip" },
    autocommand_events = { "BufWritePost" },
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
    ["<Esc>"] = { close_floating, "Close all floating windows"},
  },
  { mode = 'n' }
)

-- Broken, revisit when updated
-- require('colorful-winsep').setup({
--     no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "TodoTelescope", "Committia" },
-- })

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

require('oil').setup()

require("twoslash-queries").setup({
    multi_line = false, -- to print types in multi line mode
    is_enabled = true, -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
})

require('headlines').setup({
    markdown = {
        -- query = vim.treesitter.parse_query(
        query = vim.treesitter.query.parse(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
        ),
        headline_highlights = {
            "Headline1",
            "Headline2",
            "Headline3",
            "Headline4",
            "Headline5",
        },
        codeblock_highlight = "",
        dash_highlight = "Dash",
        dash_string = "─",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = false,
        -- fat_headline_upper_string = "▄",
        -- fat_headline_lower_string = "▀",
    },
})

-- Prefetch tabnine suggestions on file read
-- local prefetch = vim.api.nvim_create_augroup("prefetch", {clear = true})
-- vim.api.nvim_create_autocmd('BufRead', {
--   group = prefetch,
--   -- pattern = '*.py',
--   callback = function()
--     require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
--   end
-- })

require('smoothcursor').setup({
    autostart = true,
    cursor = "",              -- cursor shape (need nerd font)
    texthl = "SmoothCursor",   -- highlight group, default is { bg = nil, fg = "#FFD400" }
    linehl = nil,              -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
    type = "default",          -- define cursor movement calculate function, "default" or "exp" (exponential).
    fancy = {
        enable = true,        -- enable fancy mode
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
        -- head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
        body = {
            { cursor = "●", texthl = "SmoothCursorRed" },
            { cursor = "●", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "•", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" }
    },
    flyin_effect = nil,        -- "bottom" or "top"
    speed = 25,                -- max is 100 to stick to your current position
    intervals = 35,            -- tick interval
    priority = 10,             -- set marker priority
    timeout = 2000,            -- timout for animation
    threshold = 3,             -- animate if threshold lines jump
    disable_float_win = false, -- disable on float window
    enabled_filetypes = nil,   -- example: { "lua", "vim" }
    disabled_filetypes = nil,  -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
})

require('overseer').setup({
    bindings = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["h"] = "DecreaseDetail",
        ["l"] = "IncreaseDetail",
    }
})

-- vim.notify = require("notify")

require('kanagawa').setup({
    theme = 'dragon',
    background = {
        dark = 'dragon',
        light = 'lotus',
    },
    dimInactive = false,
    keywordStyle = { italic = false, bold = false },
    statementStyle = { italic = false, bold = true },
})

require('bufjump').setup({
    forward = '<C-n>',
    backward = '<C-p>',
    on_success = nil
})

require('highlight-undo').setup()

EOF

" firenvim
    let g:firenvim_config = {
        \ 'globalSettings': {
            \ 'alt': 'all',
        \  },
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'neovim',
                \ 'content': 'text',
                \ 'priority': 0,
                \ 'selector': 'textarea',
                \ 'takeover': 'never',
            \ },
        \ }
    \ }

    if exists('g:started_by_firenvim')
        " colorscheme github_light
        " colorscheme nordic
        " colorscheme kanagawa-lotus
        set background=light
    endif

    " set guifont=Monaco:h20
    set guifont=BlexMono\ Nerd\ Font\ Mono:h12

" " kosayoda/nvim-lightbulb
" autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({})

" Important!!
if has('termguicolors')
    set termguicolors
endif

" colorscheme github_dark_dimmed
" colorscheme nordic
colorscheme kanagawa

" " For dark version.
" set background=dark
" let g:srcery_italic = 1
" colorscheme srcery

" source $HOME/.dotfiles/vim/uolors.vim

" set background=light
" source $HOME/.dotfiles/neovim/alabaster.vim

source $HOME/.dotfiles/neovim/vimwiki.vim

" maps
source $HOME/.dotfiles/neovim/mappings.vim

" abbrevs
source $HOME/.dotfiles/neovim/abbrev.vim

augroup markdown_highlights
    highlight Headline1 guifg=Yellow
    highlight Headline2 guifg=Orange
    highlight Headline3 guifg=LightGreen
    highlight Headline4 guifg=Cyan
    highlight Headline5 guifg=Pink
augroup end

" augroup markdown_highlights
"     highlight Headline1 guifg=#cccccc guibg=#3d4f31
"     highlight Headline2 guifg=#cccccc guibg=#2f3d26
"     highlight Headline3 guifg=#cccccc guibg=#222c1b
"     highlight Headline4 guifg=#cccccc guibg=#141a10
"     highlight Headline5 guifg=#cccccc guibg=#070905
" augroup end

" augroup markdown_highlights
"     highlight markdownH1 guifg=Yellow
"     highlight markdownH2 guifg=Orange
"     highlight markdownH3 guifg=LightGreen
"     highlight markdownH4 guifg=Cyan
"     highlight markdownH5 guifg=Pink
" augroup end

" bg for hl_match_area
highlight MatchArea guibg=#303030

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=350 }
augroup end

" hi! Function gui=underline
hi! ColorColumn guifg=#adbac7 guibg=#2d3239
" ufo:
" hi! Folded guibg=#22272e


" open images with imv
autocmd BufEnter *.png,*.jpg,*.gif exec "!imv ".expand("%") | :bw
" open PDFs with zathura
autocmd BufEnter *.pdf exec "!zathura ".expand("%") | :bw

" DiffOrig
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Auto-commit & push ZK files
function! AutoCommit()
    AsyncRun bash $HOME/Bin/zk-commit.sh ${VIM_FILEPATH}
endfun
autocmd BufWritePost $ZK_NOTEBOOK_DIR/*.md call AutoCommit()
autocmd BufWritePost $ZK_NOTEBOOK_DIR/**/*.md call AutoCommit()

" reverse lines order
command -range Reverse <line1>,<line2>!tac

" vsnip snippets dir
let g:vsnip_snippet_dir = "$HOME/.dotfiles/neovim/vsnip/"

" For VS Code:
" exists('g:vscode')

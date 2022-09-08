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
set completeopt=menu,preview " show popup menu on completion with extra info
set completefunc=syntaxcomplete#Complete " set user-mode completions for <C-x><C-u>
set conceallevel=2
set cursorline " highlight cursor line
set expandtab " convert tabs to spaces
set exrc " load local .nvimrc/.exrc files
set formatoptions=cq1tj " formatting - :help fo-table
set formatoptions+=ln   " new options to test
set formatoptions-=r    " unsetting, for test
set inccommand=split  " breview `:s` replace results
set lazyredraw " do not redraw screen until needed
set linebreak " do not wrap in the middle of a word
set list " display special chars
set listchars=tab:→\ ,trail:∎  " special chars for list mode
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

-- LSP --

-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')
local on_lsp_attach = function(client, buffer)
    --local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- TODO: update capabilities with `require('cmp_nvim_lsp').update_capabilities
    -- if client.resolved_capabilities.document_formatting then
    if client.server_capabilities.documentFormattingProvider then
        -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        -- fix for a timeout error
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)")
        -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
    end
end

local on_tsserver_attach = function(client, buffer)
    -- client.resolved_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_range_formatting = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_lsp_attach(client, buffer)
end

-- jose-elias-alvarez/null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
null_ls.setup({
    sources = {
        -- null_ls.builtins.formatting.eslint.with({
        --     prefer_local = "node_modules/.bin"
        -- }),
        -- null_ls.builtins.diagnostics.eslint.with({
        --     prefer_local = "node_modules/.bin"
        -- }),
        -- null_ls.builtins.code_actions.eslint.with({
        --     prefer_local = "node_modules/.bin"
        -- }),
        null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
            condition = function(utils)
                return utils.root_has_file("node_modules/.bin/prettier")
            end,
            disabled_filetypes = {"json"},
            -- command = "node_modules/.bin/prettier",
        }),
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
        null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = {'git', 'gitcommit', 'NvimTree'} }),
        -- null_ls.builtins.diagnostics.cfn_lint.with({
        --     condition = function(utils)
        --         return null_ls_helpers.args['$FILENAME'] ~= 'serverless.yml'
        --     end,
        -- }),
    },
    on_attach = on_lsp_attach,
})

--require('lspconfig').setup()

-- RishabhRD/nvim-lsputils
-- if vim.fn.has('nvim-0.5.1') == 1 then
--     vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
--     vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
--     vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
--     vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
--     vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
--     vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
--     vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
--     vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
-- else
--     local bufnr = vim.api.nvim_buf_get_number(0)

--     vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
--         require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
--     end

--     vim.lsp.handlers['textDocument/references'] = function(_, _, result)
--         require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
--     end

--     vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
--         require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
--     end

--     vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
--         require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
--     end

--     vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
--         require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
--     end

--     vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
--         require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
--     end

--     vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
--         require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
--     end

--     vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
--         require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
--     end
-- end

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

-- -- nathanmsmith/nvim-ale-diagnostic
-- require('nvim-ale-diagnostic')
-- vim.lsp.handlers["text/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         underline = false,
--         virtual_text = false,
--         signs = true,
--         update_in_insert = false,
--     }
-- )

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

-- lsp_signature
require("lsp_signature").setup({
    bind = true,
    handler_opts = {
        border = "rounded",
    },
    hint_enable = true,
    hint_prefix = "",
})

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
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_lsp_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        },
    }

    if server.name == "tsserver" then
        opts.on_attach = on_tsserver_attach
        opts.handlers = {
            ["textDocument/definition"] = function (error, result, method, ...)
                -- vim.notify(vim.inspect(result))
                if vim.tbl_islist(result) and #result > 1 then
                    local filtered_result = filter(result, filterDTS)
                    -- vim.notify(vim.inspect(filtered_result))
                    return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
                end

                vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
            end
        }
    end

    server:setup(opts)
end)

-- local lspconfig = require('lspconfig')

-- local function on_attach(client, bufnr)
--     -- TODO
-- end
--
-- lspconfig.tsserver.setup { on_attach = on_attach }

-- rmagatti/goto-preview
-- require('goto-preview').setup {}

-- j-hui/fidget.nvim
--require('fidget').setup {}

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
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
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
            },
            selection_modes = {
                ['@function.outer'] = 'V',
                ['@function.inner'] = 'V',
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

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local cmp = require('cmp')

-- local cmp_mapping_insert = {
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<Tab>'] = cmp.mapping.confirm({ select = true }),
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
-- }
-- local cmp_mapping_cmdline = {
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<Tab>'] = cmp.mapping.confirm({ select = true }),
--     ['<Up>'] = cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
--     ['<Down>'] = cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
-- }
cmp.setup({
    -- preselect = cmp.PreselectMode.None,
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path', option = { trailing_slash = false } },
        { name = 'omni' },
        -- { name = 'tags' },
        { name = 'vsnip' },
        -- { name = 'dictionary', keyword_length = 3 },
        { name = 'emoji', insert = true },
        { name = 'calc' },
    },
    mapping = cmp.mapping.preset.insert(),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'text_symbol',
            maxwidth = 50,
            -- preset = "default",
            menu = ({
                buffer = "[Buf]",
                calc = "[Calc]",
                -- dictionary = "[Dict]",
                emoji = "[Emoji]",
                nvim_lsp = "[LSP]",
                omni = "[Omni]",
                path = "[Path]",
                -- tags = "[Tag]",
                vsnip = "[Snip]",
            }),
            symbol_map = kind_icons,
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
        ghost_text = false,
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'cmdline' },
    }
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(cmp_mapping_cmdline),
    sources = {
        { name = 'nvim_lsp_document_symbol' },
        { name = 'buffer' },
    }
})

-- require('cmp_dictionary').setup({
--     dic = {
--         ['*'] = { '/usr/share/dict/words' },
--     },
--     exact = 2,
--     first_case_insensitive = true,
--     capacity = 5,
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
                include_current_line = true,
            },
            tags = {
                max_results = 1000,
            },
        },
    },
    extensions = {
        emoji = {
            action = function(emoji)
                -- insert
                vim.api.nvim_put({ emoji.value }, 'c', false, true);
            end,
        },
    --    fzf = {
    --        fuzzy = true,
    --        override_generic_sorter = true,
    --        override_file_sorter = true,
    --        case_mode = "smart_case",
    --    },
    },
}
-- require('telescope').load_extension('fzf')
require('telescope').load_extension('vimwiki')
require('telescope').load_extension('emoji')
require('telescope').load_extension('zk')
require('telescope').load_extension('fzf')

-- github colorscheme
-- https://github.com/projekt0n/github-nvim-theme#configuration
require('github-theme').setup {
    theme_style = "dimmed",  -- dark/dark_default/dimmed/light/light_default
    hide_inactive_statusline = false,
    hide_end_of_buffer = false,
    dark_sidebar = true,
    dark_float = true,
    comment_style = "italic",
    colors = {
        -- TODO: find better colour for bg_search
        -- bg_search = "yellow",
        -- fg_search = "black",
        hint = "#707070",
        -- bg_statusline = "#00ff00",  -- test
    },
}

-- lualine
-- https://github.com/nvim-lualine/lualine.nvim#usage-and-customization
require('lualine').setup {
    options = {
        -- theme = 'github',
        theme = 'auto',
        globalstatus = false,
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = {
            -- {'diagnostics', sources={'nvim_lsp'}, sections={"error", "warn"} },
            { 'filename', path = 1 },
        },
        lualine_c = {
            {}
        },
        -- right
        lualine_x = {
            'branch',
            'diff',
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = { 'location', 'progress'  },
    }
}

-- gitsigns
require('gitsigns').setup {
    signcolumn = true,
    numhl = true,
    linehl = false,
    word_diff = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 1000,
    },
    -- Reove after upgrading to Neovim 0.7
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
        map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

        -- Actions
        map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
        map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
        map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
        map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
        map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
        map('n', '<leader>htb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
        map('n', '<leader>htd', '<cmd>Gitsigns toggle_deleted<CR>')
        map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
        map('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')

        -- Text object
        map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

-- windwp/floatline.nvim
-- https://github.com/windwp/floatline.nvim
--require('floatline').setup()

-- indent_blankline
-- require("indent_blankline").setup {
--     buftype_exclude = {"terminal", "nofile"},
--     filetype_exclude = {'floatline'},
-- }

-- neoscroll
require('neoscroll').setup()

-- trouble
require('trouble').setup {
    icons = false,
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
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = false,
    diagnostics = {
        enable = false,
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
        comments_only = false,
    },
})

-- nacro90/numb.nvim
-- https://github.com/nacro90/numb.nvim
require('numb').setup()

-- 'chentau/marks.nvim'
-- https://github.com/chentau/marks.nvim#setup
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
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "<--- 0",
  },
  bookmark_1 = {
    sign = "⚑",
    virt_text = "<--- 1"
  },
  bookmark_2 = {
    sign = "⚑",
    virt_text = "<--- 2"
  },
  bookmark_3 = {
    sign = "⚑",
    virt_text = "<--- 3"
  },
  bookmark_4 = {
    sign = "⚑",
    virt_text = "<--- 4"
  },
  bookmark_5 = {
    sign = "⚑",
    virt_text = "<--- 5"
  },
  mappings = {}
}

require('diffview').setup()

require('coverage').setup()

-- https://github.com/levouh/tint.nvim#gear-setup
require("tint").setup({
    tint = 15,
    tint_background_colors = true,
})

EOF

" kosayoda/nvim-lightbulb
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({})

" Important!!
if has('termguicolors')
    set termguicolors
endif

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
    au FileType markdown highlight htmlH1 guifg=Yellow
    au FileType markdown highlight htmlH2 guifg=Orange
    au FileType markdown highlight htmlH3 guifg=LightGreen
    au FileType markdown highlight htmlH4 guifg=Cyan
    au FileType markdown highlight htmlH5 guifg=Pink
augroup end


augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=350 }
augroup end

" hi! Function gui=underline
hi! ColorColumn guifg=#adbac7 guibg=#2d3239


" hi! link ALEVirtualTextError LspDiagnosticsVirtualTextError
" hi! link ALEVirtualTextInfo LspDiagnosticsVirtualTextInformation
" hi! link ALEVirtualTextStyleError LspDiagnosticsVirtualTextError
" hi! link ALEVirtualTextStyleWarning LspDiagnosticsVirtualTextWarning
" hi! link ALEVirtualTextWarning LspDiagnosticsVirtualTextWarning

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

" For VS Code:
" exists('g:vscode')

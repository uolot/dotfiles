" ------ General settings ------

syntax on
filetype on " enables filetype detection
filetype plugin on " enables filetype specific plugins
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

set completeopt=menu,preview " show popup menu on completion with extra info
set completefunc=syntaxcomplete#Complete " set user-mode completions for <C-x><C-u>
set cursorline " highlight cursor line
set expandtab " convert tabs to spaces
set formatoptions=cq1tj " formatting - :help fo-table
set formatoptions+=ln   " new options to test
set formatoptions-=r    " unsetting, for test
set lazyredraw " do not redraw screen until needed
set linebreak " do not wrap in the middle of a word
set list " display special chars
set listchars=tab:→\ ,trail:∎  " special chars for list mode
set nomodelineexpr  " disable modelinexpr, see: https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set mouse= " disable mouse
set nrformats-=octal  " for C-a/C-x treat octal numbers (starting with 0) as decimal numbers
set number " display line numbers
set omnifunc=syntaxcomplete#Complete " enable omnicompletion
set scrolloff=3 " keep lines above/below cursor line
set shiftround " round the indent spacing to the next multiple of shiftwidth
set shiftwidth=0 " use tabstop number of tabs to indent
set showbreak=↪ " mark wrapped lines
set showcmd " show last command on bottom
set showmatch " highlight matching bracket
set splitbelow " open new horizontal splits below
set splitright " open new vertical splits on the right
set tabstop=4 " tab key inserts 4 spaces
set title  " update terminal title
set updatetime=100
set wildignorecase  " case-insensitive wild mode
set wildmode=list:longest,full
set nowrap
set nowrapscan " do not wrap to beginning of the file when searching


source $HOME/.dotfiles/neovim/plugins.vim

lua << EOF

-- LSP --

-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local nvim_lsp = require('lspconfig')

local on_lsp_attach = function(client, buffer)
    --local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

--require('lspconfig').setup()

-- RishabhRD/nvim-lsputils
if vim.fn.has('nvim-0.5.1') == 1 then
    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
else
    local bufnr = vim.api.nvim_buf_get_number(0)

    vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
        require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
    end

    vim.lsp.handlers['textDocument/references'] = function(_, _, result)
        require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
    end

    vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
        require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
        require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
        require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
        require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
    end

    vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
    end
end

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

-- nathanmsmith/nvim-ale-diagnostic
require('nvim-ale-diagnostic')
vim.lsp.handlers["text/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
    }
)

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


-- lspinstall
local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    local lsp_server_opts = {
            on_attach = on_lsp_attach,
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        }
    local lsp_pyright_server_opts = {}
    for k, v in pairs(lsp_server_opts) do
        lsp_pyright_server_opts[k] = v
    end
    setmetatable(lsp_pyright_server_opts, getmetatable(lsp_server_opts))
    lsp_pyright_server_opts.settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    }
    for _, server in pairs(servers) do
        if server == "python" then
            require'lspconfig'[server].setup(lsp_pyright_server_opts)
        else
            require'lspconfig'[server].setup(lsp_server_opts)
        end
    end
end

setup_servers()

require'lspinstall'.post_install_hook = function ()
    setup_servers()
    vim.cmd("bufdo e")
end

-- rmagatti/goto-preview
require('goto-preview').setup {}

-- onsails/lspkind-nvim
local lspkind = require('lspkind')
lspkind.init({
    with_text = true,
    preset = "default",
})
--    symbol_map = {
--
--  "  (text)",
--  "  (method)",
--  "  (fun)",
--  "  (constructor)",
--  "ﰠ  (field)",
--  " (var)",
--  "ﴯ  (class)",
--  "  (interface)",
--  "  (module)",
--  "ﰠ  (property)",
--  "塞 (unit)",
--  "  (value)",
--  "  (enum)",
--  "  (keyword)",
--  "  (snippet)",
--  "  (color)",
--  "  (file)",
--  "  (reference)",
--  "  (folder)",
--  "  (enum-member)",
--  "  (constant)",
--  "פּ  (struct)",
--  "  (event)",
--  "  (operator)",
--  "   (type-param)"
--
--    }
--})

-- Treesitter --
-- nvim-treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
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
        highlight_definitions = { enable = true },
        -- highlight_current_scope = { enable = true },
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
                ["ai"] = "@block.outer",
                ["ii"] = "@block.inner",
            },
        },
--        move = {
--            enable = true,
--            set_jumps = true,
--            goto_next_start = {
--                ["]]"] = "@class.outer",
--                ["]m"] = "@function.outer",
--                ["]b"] = "@block.outer",
--            },
--            goto_previous_start = {
--                ["[["] = "@class.outer",
--                ["[m"] = "@function.outer",
--                ["[b"] = "@block.outer",
--            },
--        },
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


--require('nvim-ts-autotag').setup()

-- Completion --

-- tzachar/cmp-tabnine
-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup(
-- {
--     max_lines = 1000,
--     max_num_results = 20,
--     sort = true,
--     run_on_every_keystroke = true,
-- })

-- nvim-cmp
local source_mapping = {
	nvim_lsp = "[LSP]",
	-- cmp_tabnine = "[TN]",
	buffer = "[Buffer]",
	path = "[Path]",
    tags = "[Tag]",
}

local cmp = require'cmp'
cmp.setup({
    completion = {
        autocomplete = true,
    },
    sources = {
        { name = 'nvim_lsp' },
        -- { name = 'cmp_tabnine' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'tags' },
        --{ name = 'omni' },
        --{ name = 'tresitter' },
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
			local menu = source_mapping[entry.source.name]
			if entry.source.name == 'cmp_tabnine' then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    vim_item.kind = '' .. " " .. entry.completion_item.data.detail
					--menu = entry.completion_item.data.detail .. ' ' .. menu
				end
				--vim_item.kind = ''
			end
			vim_item.menu = menu
			return vim_item
		end
	},
})

-- Telescope
require('telescope').setup {
    defaults = require('telescope.themes').get_ivy {
        pickers = {
            find_files = {
                theme = "ivy",
            },
            live_grep = {
                only_sort_text = true,
            },
            tags = {
                max_results = 1000,
            },
        },
    },
    --extensions = {
    --    fzf = {
    --        fuzzy = true,
    --        override_generic_sorter = true,
    --        override_file_sorter = true,
    --        case_mode = "smart_case",
    --    },
    --},
}
-- require('telescope').load_extension('fzf')

-- lualine
local gps = require("nvim-gps")
require('lualine').setup {
    options = {
        -- theme = 'github',
        theme = 'auto',
        --section_separators = '',
        --component_separators = '',
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            {'diagnostics', sources={'nvim_lsp'}, sections={"error", "warn"} }
        },
        lualine_c = {
            { 'filename', path = 1 },
            { gps.get_location, cond = gps.is_available }
        },
        -- right
        lualine_x = {},  -- { 'filetype' },
        lualine_y = {
            -- { 'diff', diff_color = {added=nil, modified=nil, removed=nil} },
            'filetype',
        },
        lualine_z = { 'location', 'progress'  },
    }
}

-- github colorscheme
-- https://github.com/projekt0n/github-nvim-theme#configuration
require('github-theme').setup {
    theme_style = "dimmed",
    hide_inactive_statusline = false,
    hide_end_of_buffer = false,
    dark_sidebar = true,
    dark_float = true,
    comment_style = "italic",
    colors = {
        bg_search = "yellow",
        fg_search = "black",
        hint = "#707070",
        -- bg_statusline = "#00ff00",  -- test
    },
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

-- iswap
require('iswap').setup {
    autoswap = true,
    grey = 'disable',
}

-- Darazaki/indent-o-matic
--require('indent-o-matic').setup {}

-- SmiteshP/nvim-gps
-- https://github.com/SmiteshP/nvim-gps
require("nvim-gps").setup({
	icons = {
		["class-name"] = '',      -- Classes and class-like objects
		["function-name"] = '',   -- Functions
		["method-name"] = '',     -- Methods (functions inside class-like objects)
		["container-name"] = '',  -- Containers (example: lua tables)
		["tag-name"] = ''         -- Tags (example: html tags)
	},
	-- Disable any languages individually over here
	-- Any language not disabled here is enabled by default
	separator = ' ',
})

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
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    open_on_tab = false,
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    hijack_cursor = true,
    update_cwd = false,
    lsp_diagnostics = false,
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    view = {
        width = 30,
        side = 'left',
        auto_resize = false,
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
require("todo-comments").setup()

-- nacro90/numb.nvim
-- https://github.com/nacro90/numb.nvim
require('numb').setup()

EOF

" kosayoda/nvim-lightbulb
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" gelguy/wilder.nvim
" call wilder#setup({'modes': [':', '/', '?']})
" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     wilder#cmdline_pipeline({
"       \       'fuzzy': 1,
"       \       'set_pcre2_pattern': has('nvim'),
"       \     }),
"       \     wilder#python_search_pipeline({
"       \       'pattern': 'fuzzy',
"       \     }),
"       \   ),
"       \ ])
" call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
"       \ 'highlighter': wilder#basic_highlighter(),
"       \ 'highlights': {
"       \   'border': 'Normal',
"       \ },
"       \ 'border': 'rounded',
"       \ })))

" Important!!
if has('termguicolors')
    set termguicolors
endif
" For dark version.
set background=dark

"let g:monochrome_italic_comments = 1
"colorscheme monochrome
" source $HOME/.dotfiles/vim/uolors.vim

"filetype plugin indent on

" maps
source $HOME/.dotfiles/neovim/mappings.vim

highlight CursorWord0 ctermbg=239
highlight CursorWord1 term=none cterm=none gui=none

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=350 }
augroup end

hi! link ALEVirtualTextError LspDiagnosticsVirtualTextError
hi! link ALEVirtualTextInfo LspDiagnosticsVirtualTextInformation
hi! link ALEVirtualTextStyleError LspDiagnosticsVirtualTextError
hi! link ALEVirtualTextStyleWarning LspDiagnosticsVirtualTextWarning
hi! link ALEVirtualTextWarning LspDiagnosticsVirtualTextWarning
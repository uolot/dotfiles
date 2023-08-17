local cmp = require('cmp')
local lspkind = require('lspkind')

require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
})

require('copilot_cmp').setup()

local sources = {
    { name = 'nvim_lsp' },
    {
        name = 'buffer',
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
    { name = 'copilot' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'treesitter' },
    { name = 'vsnip' },
    { name = 'path',                   option = { trailing_slash = false } },
    { name = 'calc' },
    { name = 'emoji',                  option = { insert = true } },
    -- { name = 'cmp_tabnine', max_item_count = 3, priority = 8 },
    -- { name = 'omni', max_item_count = 5, priority = 4 },
}

--[[
local sources = {
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
}
]]

local mapping = cmp.mapping.preset.insert({
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
})

local sorting = {
    priority_weight = 2,
    comparators = {
        cmp.config.compare.score,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.locality,
        cmp.config.compare.recently_used,
        cmp.config.compare.order,
        -- cmp.config.compare.locallity,
        require('copilot_cmp.comparators').prioritize,
        cmp.config.compare.sort_text,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        -- cmp.config.compare.length,
        -- cmp.config.compare.scopes,
    },
}

local formatting = {
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
            treesitter = "[Tree]",
            vsnip = "[VSnip]",
        }),
        -- symbol_map = kind_icons,
    }),
}

cmp.setup({
    -- preselect = cmp.PreselectMode.None,
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    sources = sources,
    performance = {
        max_view_options = 20,
    },
    mapping = mapping,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = formatting,
    sorting = sorting,
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

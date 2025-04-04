-- require('CopilotChat.integrations.cmp').setup()

local dependencies = {
    -- sources
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-calc' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-path' },
    { 'ray-x/cmp-treesitter' },
    { 'quangnguyen30192/cmp-nvim-tags',      ft = { 'markdown' } },

    -- comparators
    { 'lukas-reineke/cmp-under-comparator',  url = 'https://github.com/lukas-reineke/cmp-under-comparator' },

    -- snippet plugin is required by nvim-cmp
    {
        'hrsh7th/vim-vsnip',
        config = function()
            vim.g.vsnip_snippet_dir = "$HOME/.dotfiles/neovim/vsnip/"
        end
    },
    { 'hrsh7th/vim-vsnip-integ', url = 'https://github.com/hrsh7th/vim-vsnip-integ' },
    { 'hrsh7th/cmp-vsnip',       url = 'https://github.com/hrsh7th/cmp-vsnip' },

    -- copilot
    {
        'zbirenbaum/copilot-cmp',
        dependencies = { 'zbirenbaum/copilot.lua' },
    },
}

local function config()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    require('copilot').setup({
        -- cmd = 'Copilot',
        -- event = 'InsertEnter',
        copilot_model = 'gpt-4o-copilot',
        -- suggestion = { enabled = false },
        suggestion = { enabled = true, auto_trigger = true },
        panel = { enabled = false },
        filetypes = {
            ['*'] = true,
            ['.env'] = false,
        },
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
        { name = 'lazydev' },
        { name = 'calc' },
        { name = 'emoji',                  option = { insert = true } },
        { name = 'tags',                   options = { current_buffer_only = false } },
        -- { name = 'cmp_tabnine' },
        -- { name = 'omni' },
    }

    local mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = function(fallback)
            if cmp.visible() then
                cmp.mapping.scroll_docs(-1)
            else
                fallback()
            end
        end,
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
            elseif vim.fn["vsnip#jumpable"](1) ~= 0 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-next)", true, true, true), "")
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](1) ~= 0 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
            else
                fallback()
            end
        end,
    })

    local sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            cmp.config.compare.locality,
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
            -- mode = 'text_symbol',
            mode = 'text',
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
        view = {
            entries = {
                -- name = 'custom',
                follow_cursor = true,
                vertical_positioning = 'below',
            },
        },
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
end

return {
    config = config,
    dependencies = dependencies,
}

local function getlines(location)
    local uri = location.targetUri or location.uri
    if uri == nil then
        return
    end
    local bufnr = vim.uri_to_bufnr(uri)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end
    local range = location.targetRange or location.range

    local lines = vim.api.nvim_buf_get_lines(bufnr, range.start.line, range['end'].line + 1, false)
    return table.concat(lines, '\n')
end

local function float_format(diag)
    print('diag')
    print(vim.inspect(diag))

    local message = diag.message

    local clients = vim.lsp.get_clients({ bufnr = diag.bufnr })
    -- local client = vim.lsp.get_active_clients({ name = message.source })[1]
    -- local client = vim.lsp.get_clients()[1]

    local relatedInfo = { messages = {}, locations = {} }

    for index, client in ipairs(clients) do
        if not client then
            print('no client')
            goto continue
            -- return diag.message
        end

        print('client')
        print(vim.inspect(client.name))

        if not diag.user_data or not diag.user_data.lsp then
            print('no diag.user_data.lsp')
            goto continue
        end

        if not diag.user_data.lsp.relatedInformation then
            print('no diag.user_data.lsp.relatedInformation')
            goto continue
        end

        for _, info in ipairs(diag.user_data.lsp.relatedInformation) do
            table.insert(relatedInfo.messages, info.message)
            table.insert(relatedInfo.locations, info.location)
        end

        for i, loc in ipairs(vim.lsp.util.locations_to_items(relatedInfo.locations, client.offset_encoding)) do
            message = string.format("%s\n%s (%s:%d):\n\t%s", message, relatedInfo.messages[i],
                vim.fn.fnamemodify(loc.filename, ':.'), loc.lnum,
                getlines(relatedInfo.locations[i]))
        end

        ::continue::
    end

    return message
end

-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
vim.diagnostic.config({
    virtual_text = {
        -- source = false,
        source = "if_many",
        prefix = '●',
        spacing = 1,
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        header = '',
        border = "rounded",
        -- source = true,
        source = 'if_many',
        format = float_format,
    },
    signs = true,
    -- virtual_lines = false,
})

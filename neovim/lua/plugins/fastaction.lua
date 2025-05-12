local function reverse(array)
    local reversed = {}
    for i = #array, 1, -1 do
        table.insert(reversed, array[i])
    end
    return reversed
end

local function get_first_char(s)
    return s:sub(1, 1)
end

local function get_candidates(path)
    local path_segments = vim.split(path, '/', { plain = true })
    local fname = vim.split(path_segments[#path_segments], '.', { plain = true })[1]

    local path_segments_reversed = reverse(vim.list_slice(path_segments, 1, #path_segments - 1))
    local path_first_letters_array = vim.tbl_map(get_first_char, path_segments_reversed)
    local path_first_letters = vim.iter(path_first_letters_array):join('')

    return vim.iter({
        -- first letter of filename
        get_first_char(fname),
        -- first letter of file name parts
        vim.iter(vim.split(fname, '[-_ ]')):map(get_first_char):join(''),
        -- first letter of each segment except last, reversed
        path_first_letters,
        -- filename
        fname,
        -- full relative path
        path,
    }):join('')
end

local function override_function(params) -- to retain built-in style keymaps
    if params.kind ~= "buffer" then return nil end
    if params.title == nil or params.title == '' or #params.valid_keys == 0 then return nil end

    params.title = string.lower(params.title):lower()
    local candidates = get_candidates(params.title)

    local index = 1
    local increment = #params.valid_keys[1]
    repeat
        local char = candidates:sub(index, index + increment - 1)
        if
            char:match '[a-z]+'
            and not vim.tbl_contains(params.invalid_keys, char)
            and vim.tbl_contains(params.valid_keys, char)
        then
            return { key = char, order = 10 } -- M.AUTO_ORDER
        end
        index = index + increment
    until index >= #candidates
end

local opts = {
    override_function = override_function,
    register_ui_select = true,
    popup = {
        relative = 'cursor',
    }
}

return { opts = opts }

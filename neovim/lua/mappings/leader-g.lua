local wk = require("which-key")
local telescope = require("telescope.builtin")
local actions_preview = require("actions-preview")
local snacks = require("snacks")

local function go_to_definition()
    if vim.bo.filetype == "typescript" then
        vim.cmd("TSToolsGoToSourceDefinition")
    else
        vim.lsp.buf.definition()
    end
end

local function next_usage()
    snacks.words.jump(1, true)
end

local function previous_usage()
    snacks.words.jump(-1, true)
end

wk.add({
    { "<Leader>g",  group = "+lsp" },
    {
        mode = { "n", "v", "x" },
        { "<Leader>ga", actions_preview.code_actions, desc = "Code Action" },
    },
    { "<Leader>ge", vim.diagnostic.open_float,           desc = "Show current line diagnostics" },
    -- { "<Leader>gd", go_to_definition,                    desc = "Go to definition" },
    { "<Leader>gd", vim.lsp.buf.definition,              desc = "Go to definition" },
    { "<Leader>gD", vim.lsp.buf.declaration,             desc = "Go to declaration" },
    { "<Leader>gf", Snacks.picker.lsp_references,        desc = "Find references" },
    { "<Leader>gh", vim.lsp.buf.hover,                   desc = "Hover" },
    { "<Leader>gi", telescope.lsp_incoming_calls,        desc = "Incoming calls" },
    -- { "<Leader>gi", vim.lsp.buf.incoming_calls,              desc = "Incoming calls" },
    { "<Leader>gj", next_usage,                          desc = "Next usage" },
    { "<Leader>gk", previous_usage,                      desc = "Previous usage" },
    { "<Leader>gm", vim.lsp.buf.implementation,          desc = "Go to implementation" },
    { "<Leader>go", telescope.lsp_outgoing_calls,        desc = "Outgoing calls" },
    -- { "<Leader>go", vim.lsp.buf.outgoing_calls,              desc = "Outgoing calls" },
    { "<Leader>gr", vim.lsp.buf.rename,                  desc = "Rename" },
    { "<Leader>gR", ":IncRename <C-r><C-w>",             desc = "Inc rename" },
    { "<Leader>gs", Snacks.picker.lsp_symbols,           desc = "Document symbols" },
    { "<Leader>gS", Snacks.picker.lsp_workspace_symbols, desc = "Workspace symbols" },
    { "<Leader>gt", vim.lsp.buf.type_definition,         desc = "Go to type definition" },
    { "<Leader>gx", Snacks.picker.diagnostics_buffer,    desc = "Buffer diagnostics" },
    { "<Leader>gX", Snacks.picker.diagnostics,           desc = "All buffers diagnostics" },
    {
        { "<Leader>gw",  group = "Workspace" },
        { "<Leader>gwa", vim.lsp.buf.add_workspace_folder,    desc = "Add workspace folder" },
        { "<Leader>gwr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
        { "<Leader>gwl", vim.lsp.buf.list_workspace_folders,  desc = "List workspace folders" },
    },
})

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

local function lsp_references()
    telescope.lsp_references({ fname_width = 70, trim_text = true })
end

local function buffer_diagnostics()
    telescope.diagnostics({ bufnr = 0 })
end

local function next_usage()
    snacks.words.jump(1, true)
end

local function previous_usage()
    snacks.words.jump(-1, true)
end

local buf_lsp = vim.lsp.buf

wk.add({
    { "<Leader>g",  group = "+lsp" },
    { "<Leader>ga", actions_preview.code_actions,            desc = "Code Action",                  mode = { "n", "v", "x" } },
    { "<Leader>ge", vim.diagnostic.open_float,               desc = "Show current line diagnostics" },
    { "<Leader>gd", go_to_definition,                        desc = "Go to definition" },
    { "<Leader>gD", buf_lsp.declaration,                     desc = "Go to declaration" },
    { "<Leader>gf", lsp_references,                          desc = "Find references" },
    { "<Leader>gh", buf_lsp.hover,                           desc = "Hover" },
    { "<Leader>gi", telescope.lsp_incoming_calls,            desc = "Incoming calls" },
    { "<Leader>gj", next_usage,                              desc = "Next usage" },
    { "<Leader>gk", previous_usage,                          desc = "Previous usage" },
    { "<Leader>gm", buf_lsp.implementation,                  desc = "Go to implementation" },
    { "<Leader>go", telescope.lsp_outgoing_calls,            desc = "Outgoing calls" },
    { "<Leader>gr", buf_lsp.rename,                          desc = "Rename" },
    { "<Leader>gR", ":IncRename <C-r><C-w>",                 desc = "Inc rename" },
    { "<Leader>gs", telescope.lsp_document_symbols,          desc = "Document symbols" },
    { "<Leader>gS", telescope.lsp_dynamic_workspace_symbols, desc = "Workspace symbols" },
    { "<Leader>gt", buf_lsp.type_definition,                 desc = "Go to type definition" },
    { "<Leader>gx", buffer_diagnostics,                      desc = "Buffer diagnostics" },
    { "<Leader>gX", telescope.diagnostics,                   desc = "All buffers diagnostics" },
    {
        { "<Leader>gw",  group = "Workspace" },
        { "<Leader>gwa", buf_lsp.add_workspace_folder,    desc = "Add workspace folder" },
        { "<Leader>gwr", buf_lsp.remove_workspace_folder, desc = "Remove workspace folder" },
        { "<Leader>gwl", buf_lsp.list_workspace_folders,  desc = "List workspace folders" },
    },
})

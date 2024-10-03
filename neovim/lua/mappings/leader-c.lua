local wk = require("which-key")

wk.add({
    mode = { "n", "x" },
    { "<Leader>c",  group = "Copilot Chat" },
    { "<Leader>cc", ":CopilotChatToggle<CR>", desc = "Toggle" },
    {
        "<Leader>cq",
        function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
        end,
        desc = "Quick chat",
    },
    { "<Leader>cs", ":CopilotChatStop<CR>", desc = "Stop" },
    {
        { "<Leader>cp",  group = "Prompts" },
        { "<Leader>cpd", ":CopilotChatDocs<CR>",          desc = "Docs" },
        { "<Leader>cpe", ":CopilotChatExplain<CR>",       desc = "Explain" },
        { "<Leader>cpf", ":CopilotChatFix<CR>",           desc = "Fix" },
        { "<Leader>cpo", ":CopilotChatOptimize<CR>",      desc = "Optimize" },
        { "<Leader>cpr", ":CopilotChatReview<CR>",        desc = "Review" },
        { "<Leader>cpt", ":CopilotChatTests<CR>",         desc = "Tests" },
        { "<Leader>cpx", ":CopilotChatFixDiagnostic<CR>", desc = "Fix diagnostics" },
    },
    {
        { "<Leader>cg",  group = "Git" },
        { "<Leader>cgc", ":CopilotChatCommit<CR>",       desc = "Commit" },
        { "<Leader>cgs", ":CopilotChatCommitStaged<CR>", desc = "Commit staged" },
    },
})

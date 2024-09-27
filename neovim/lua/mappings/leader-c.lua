local wk = require("which-key")

wk.add({
    mode = { "n", "x" },
    { "<Leader>c",  group = "Copilot Chat" },
    { "<Leader>cc", ":CopilotChatCommit<CR>",         desc = "Commit" },
    { "<Leader>cC", ":CopilotChatCommitStaged<CR>",   desc = "Commit staged" },
    { "<Leader>cd", ":CopilotChatDocs<CR>",           desc = "Docs" },
    { "<Leader>ce", ":CopilotChatExplain<CR>",        desc = "Explain" },
    { "<Leader>cf", ":CopilotChatFix<CR>",            desc = "Fix" },
    { "<Leader>co", ":CopilotChatOptimize<CR>",       desc = "Optimize" },
    { "<Leader>cr", ":CopilotChatReview<CR>",         desc = "Review" },
    { "<Leader>ct", ":CopilotChatTests<CR>",          desc = "Tests" },
    { "<Leader>cx", ":CopilotChatFixDiagnostics<CR>", desc = "Fix diagnostics" },
    {
        "<Leader>cq",
        function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
        end,
        desc = "Quick chat",
    }
})

return {
    name = '+copilot',
    c = { ':CopilotChatCommit<CR>', 'Commit' },
    C = { ':CopilotChatCommitStaged<CR>', 'Commit staged' },
    d = { ':CopilotChatDocs<CR>', 'Docs' },
    e = { ':CopilotChatExplain<CR>', 'Explain' },
    f = { ':CopilotChatFix<CR>', 'Fix' },
    o = { ':CopilotChatOptimize<CR>', 'Optimize' },
    r = { ':CopilotChatReview<CR>', 'Review' },
    t = { ':CopilotChatTests<CR>', 'Tests' },
    x = { ':CopilotChatFixDiagnostics<CR>', 'Fix diagnostics' },
    q = {
        function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
        end,
        desc = "Quick chat",
    }
}

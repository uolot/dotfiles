local wk = require("which-key")
local opencode = require("opencode")

local context_options = {
	"@this",
	"@buffer",
	"@buffers",
	"@visible",
	"@diagnostics",
	"@quickfix",
	"@diff",
	"@marks",
}

local prompt_options = {
	"diagnostics",
	"diff",
	"document",
	"explain",
	"fix",
	"implement",
	"optimize",
	"review",
	"test",
}

local function ask(context)
	if not context then
		context = ""
	else
		context = context .. ": "
	end
	return function()
		return opencode.ask(context, { submit = true })
	end
end

local function ask_selection()
	vim.ui.select(context_options, { prompt = "Select opencode context:" }, function(choice)
		if choice then
			ask(choice)()
		end
	end)
end

local function operator()
	return opencode.operator("@this ")
end

local function line()
	return opencode.operator("@this ") .. "_"
end

local function prompt()
	vim.ui.select(prompt_options, { prompt = "Select opencode prompt:" }, function(choice)
		if choice then
			opencode.prompt(choice, { submit = true })
		end
	end)
end

local function prompt_selection()
	vim.ui.select(context_options, { prompt = "Select opencode context:" }, function(context_choice)
		if context_choice then
			vim.ui.select(prompt_options, { prompt = "Select opencode prompt:" }, function(prompt_choice)
				if prompt_choice then
					opencode.prompt(prompt_choice, { context = context_choice, submit = true })
				end
			end)
		end
	end)
end

wk.add({
	mode = { "n", "x" },
	-- ask
	{ "<Leader>oa", ask(), desc = "Ask opencode" },
	{ "<Leader>oA", ask_selection, desc = "Ask opencode with context selection" },
	{ "<Leader>ot", ask("@this"), desc = "Ask opencode with @this context" },
	{ "<Leader>ob", ask("@buffer"), desc = "Ask opencode with @buffer context" },
	{ "<Leader>od", ask("@diagnostics"), desc = "Ask opencode with @diagnostics context" },
	-- prompt
	{ "<Leader>op", prompt, desc = "Select and execute opencode prompt" },
	{ "<Leader>oP", prompt_selection, desc = "Select opencode context and prompt" },
	-- misc
	{ "<Leader>oc", opencode.command, desc = "Execute opencode command" },
	{ "<Leader>os", opencode.select, desc = "Select and execute opencode action" },
	{ "<Leader>ol", line, desc = "Add line to opencode", expr = true },
	{ "<Leader>oo", operator, desc = "Add range to opencode", expr = true },
	{ "<Leader>ox", opencode.toggle, desc = "Toggle opencode" },
})

--[[

### Contexts

`opencode.nvim` replaces placeholders in prompts with the corresponding context:

| Placeholder    | Context                                                         |
| -------------- | --------------------------------------------------------------- |
| `@this`        | Operator range or visual selection if any, else cursor position |
| `@buffer`      | Current buffer                                                  |
| `@buffers`     | Open buffers                                                    |
| `@visible`     | Visible text                                                    |
| `@diagnostics` | Current buffer diagnostics                                      |
| `@quickfix`    | Quickfix list                                                   |
| `@diff`        | Git diff                                                        |
| `@marks`       | Global marks                                                    |
| `@grapple`     | [grapple.nvim](https://github.com/cbochs/grapple.nvim) tags     |

### Prompts

Select or reference prompts to review, explain, and improve your code:

| Name          | Prompt                                                                 |
| ------------- | ---------------------------------------------------------------------- |
| `diagnostics` | Explain `@diagnostics`                                                 |
| `diff`        | Review the following git diff for correctness and readability: `@diff` |
| `document`    | Add comments documenting `@this`                                       |
| `explain`     | Explain `@this` and its context                                        |
| `fix`         | Fix `@diagnostics`                                                     |
| `implement`   | Implement `@this`                                                      |
| `optimize`    | Optimize `@this` for performance and readability                       |
| `review`      | Review `@this` for correctness and readability                         |
| `test`        | Add tests for `@this`                                                  |

	]]
--

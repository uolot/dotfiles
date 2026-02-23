local wk = require("which-key")
local opencode = require("opencode")

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
local function ask()
	return opencode.ask("@this: ", { submit = true })
end

local function operator()
	return opencode.operator("@this ")
end

local function line()
	return opencode.operator("@this ") .. "_"
end

wk.add({
	mode = { "n", "x" },
	{ "<Leader>oa", ask, desc = "Ask opencode" },
	{ "<Leader>os", opencode.select, desc = "Execute opencode action" },
	{ "<Leader>ot", opencode.toggle, desc = "Toggle opencode" },
	{ "<Leader>oo", operator, desc = "Add range to opencode", expr = true },
	{ "<Leader>ol", operator, desc = "Add line to opencode", expr = true },
	{ "<Leader>op", opencode.prompt, desc = "opencode prompt" },
	{ "<Leader>oc", opencode.command, desc = "opencode command" },
})

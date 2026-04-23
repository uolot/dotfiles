return {
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = false,
			sections = {
				{ section = "header" },
				{ section = "startup", padding = 1 },
			},
		},
		indent = {
			enabled = true,
			animate = { enabled = false },
			scope = { enabled = true },
			chunk = {
				enabled = true,
				char = {
					corner_top = "╭",
					corner_bottom = "╰",
					horizontal = "─",
					vertical = "│",
					arrow = "─",
				},
			},
		},
		input = {
			enabled = true,
			relative = "cursor",
			row = -3,
			col = 0,
		},
		notifier = {
			enabled = true,
			timeout = 6000,
		},
		picker = { -- Enhances `select()`
			actions = {
				opencode_send = function(...)
					return require("opencode").snacks_picker_send(...)
				end,
			},
			win = {
				input = {
					keys = {
						["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
					},
				},
			},
		},
		quickfile = { enabled = true },
		statuscolumn = {
			enabled = true,
			left = { "mark", "fold" }, -- priority of signs on the left (high to low)
			right = { "sign", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = true, -- show open fold icons
				git_hl = false, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50, -- refresh at most every 50ms
		},
		terminal = {}, -- Enables the `snacks` provider
		words = {
			enabled = true,
			debounce = 200,
			notify_jump = false,
			notify_end = true,
		},
	},
}

local opts = {
	signs = true,
	merge_keywords = true,
	highlight = {
		multiline = false,
		comments_only = true,
		-- before = "fg",
		keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		-- after = "fg",
		exclude = {
			"help",
			"lazy",
			"lspinfo",
			"mason",
			"terminal",
		},
	},
}

return { opts = opts }

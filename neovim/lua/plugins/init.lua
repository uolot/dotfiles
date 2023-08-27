local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- top plugins
	{ "lewis6991/impatient.nvim" },
	{ "folke/neodev.nvim",         opts = {}, ft = 'lua', priority = 1000 },

	-- dependencies
	{ "nvim-lua/plenary.nvim" },
	{ "kevinhwang91/promise-async" },

	--
	-- cmp
	--

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		dependencies = require("plugins.cmp").dependencies,
		config = require("plugins.cmp").config,
	},

	--
	-- lsp
	--

	-- Plug 'williamboman/nvim-lsp-installer'
	{ "neovim/nvim-lspconfig",            dependencies = { "folke/neodev.nvim" } },
	{ "williamboman/mason.nvim",          build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "VonHeikemen/lsp-zero.nvim",        branch = "v2.x" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
	},
	{ "jay-babu/mason-null-ls.nvim" },
	{ "RishabhRD/popfix" },
	{ "RishabhRD/nvim-lsputils" },
	{ "onsails/lspkind-nvim" },
	-- { 'kosayoda/nvim-lightbulb' },
	{
		"folke/trouble.nvim",
		lazy = true,
		opts = {
			icons = false,
			severity = vim.diagnostic.severity.INFO,
		},
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"weilbith/nvim-code-action-menu",
		},
		config = function()
			require("refactoring").setup()
		end,
	},

	-- Pop-up menu for code actions to show meta-information and diff preview
	--     Provides ":CodeActionMenu"
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},

	-- Incremental LSP rename command based on Neovim's command-preview feature
	{ "smjonas/inc-rename.nvim" },

	-- Nvim lua plugin which adds support for twoslash queries into typescript projects
	{
		"marilari88/twoslash-queries.nvim",
		opts = {
			multi_line = false, -- to print types in multi line mode
			is_enabled = true, -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
		},
	},
	{ "elentok/format-on-save.nvim", config = require("plugins.format-on-save").config },

	--
	-- treesitter
	--

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		priority = 900,
		config = function()
			require("plugins.treesitter")
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "nvim-treesitter/nvim-treesitter-refactor" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	-- Use treesitter to auto close and auto rename html tags
	{ "windwp/nvim-ts-autotag" },

	--
	-- telescope
	--

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		lazy = true,
		config = require("plugins.telescope").config,
	},
	{ "kelly-lin/telescope-ag" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		lazy = true,
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},

	--
	-- colors & highlighting
	--

	{ "nvim-lualine/lualine.nvim", opts = require("plugins.lualine").opts },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd("colorscheme kanagawa")
		end,
		opts = {
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
			dimInactive = false,
			keywordStyle = { italic = false, bold = false },
			statementStyle = { italic = false, bold = true },
		},
	},
	-- disables search highlighting when you are done searching and re-enables it when you search again
	{ "romainl/vim-cool" },
	-- highlighting visual selections
	{ "Pocco81/HighStr.nvim" },
	-- Highlight several words in different colors simultaneously
	{
		"inkarkat/vim-mark",
		keys = { "<Plug>MarkSet", "<Plug>MarkToggle", "<Plug>MarkClear" },
		dependencies = { "inkarkat/vim-ingo-library" },
		init = function()
			vim.g.mw_no_mappings = 1
			vim.g.mwDefaultHighlightingPalette = "extended"
		end,
	},
	-- Highlight, list and search todo comments in your projects
	{
		"folke/todo-comments.nvim",
		lazy = false,
		opts = {
			signs = false,
			highlight = {
				multiline = false,
				-- pattern = [[.*<(KEYWORDS)\s*:]],
				pattern = [[.*<(KEYWORDS)\s*]],
				comments_only = true,
			},
			search = {
				pattern = [[\b(KEYWORDS)\b]],
			},
		},
	},
	{
		"levouh/tint.nvim",
		config = function()
			require("tint").setup({
				tint = 15,
				tint_background_colors = true,
			})
		end,
	},
	-- Easily add additional highlights to your buffers
	{ "folke/paint.nvim",        opts = require("plugins.paint").opts },
	{
		"tzachar/highlight-undo.nvim",
		keys = { "u", "U", "<C-r>" },
		opts = {},
	},

	--
	-- file explorer
	--

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = require("plugins.neo-tree").dependencies,
	},

	--
	-- git
	--

	{ "tpope/vim-fugitive",      lazy = false },
	{ "lewis6991/gitsigns.nvim", opts = require("plugins.gitsigns").opts },
	-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
	{ "sindrets/diffview.nvim",  cmd = { "DiffviewFileHistory", "DiffviewClose", "DiffviewOpen" } },
	-- more pleasant editing on commit messages
	{ "rhysd/committia.vim" },
	-- GitHub extension for fugitive.vim
	{ "tpope/vim-rhubarb" },
	{
		"drzel/vim-repo-edit",
		cmd = { "RepoEdit", "RepoEditGithub" },
		config = require("plugins.repo-edit").config,
	},

	--
	-- markdown
	--
	{
		"iamcco/markdown-preview.nvim",
		cmd = 'MarkdownPreviewToggle',
		config = function()
			vim.fn["mkdp#util#install"]()
			vim.g.mkdp_auto_close = 0
		end,
	},
	{
		"mickael-menu/zk-nvim",
		lazy = true,
		config = function()
			require("zk").setup({ picker = "telescope" })
		end,
	},
	{
		"preservim/vim-markdown",
		ft = { "markdown" },
		config = function()
			vim.g.vim_markdown_folding_disabled = 0
			vim.g.vim_markdown_no_default_key_mappings = 1
			vim.g.vim_markdown_toc_autofit = 1
			vim.g.vim_markdown_conceal_code_blocks = 0
			vim.g.vim_markdown_strikethrough = 1
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_toml_frontmatter = 1
		end,
	},
	-- Additional highlights for markdown
	{
		"lukas-reineke/headlines.nvim",
		lazy = true,
		ft = { "markdown" },
		config = require("plugins.headlines").config,
	},

	--
	-- misc
	--

	-- TODO: use treesitter texobjects indent instead?
	{ "michaeljsmith/vim-indent-object" },
	-- Readline style insertion
	{ "tpope/vim-rsi",                  keys = { ":", "/", "?" } },
	-- handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
	{ "kopischke/vim-fetch" },
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = { "n", "x" } },
			{ "gCC", mode = { "n", "x" } },
			{ "gc",  mode = { "n", "x" } },
			{ "gC",  mode = { "n", "x" } },
		},
		opts = {
			toggler = {
				line = "gcc",
				block = "gCC",
			},
			opleader = {
				line = "gc",
				block = "gC",
			},
		},
	},
	{ "folke/which-key.nvim",     opts = require("plugins.which-key").opts },
	{ "chentoast/marks.nvim",     opts = require("plugins.marks").opts },
	-- Run Async Shell Commands
	{ "skywind3000/asyncrun.vim", cmd = "AsyncRun" },

	-- Set of operators and textobjects to search/select/edit sandwiched texts
	{ "machakann/vim-sandwich" },
	-- Additional text objects
	-- Provides:
	-- iX aX IX AX where X = () [] {} <> t ' " ` , . ; : + - = ~ _ * # / | \ & $
	-- inX anX AnX InX for next object
	-- ilX alX AlX IlX for previous (last) object
	-- ia aa Ia Aa for arguments; works with nX/lX as well
	{ "wellle/targets.vim" },
	{
		"godlygeek/tabular",
		cmd = "Tabularize",
	},
	-- Heuristically set buffer options
	{ "tpope/vim-sleuth" },
	{
		"sindrets/winshift.nvim",
		lazy = true,
		cmd = "WinShift",
		opts = { highlight_moving_win = true },
	},
	{
		"gbrlsnchs/winpick.nvim",
		lazy = true,
		opts = { border = "rounded" },
	},
	-- hide gutter numbers for folds
	{ "luukvbaal/statuscol.nvim",            config = require("plugins.statuscol").config },
	-- ultra fold
	{ "kevinhwang91/nvim-ufo",               opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", opts = require("plugins.indent-blankline").opts },
	-- Inversed J
	{
		"AckslD/nvim-trevJ.lua",
		-- keys = { 'K' },
		config = function()
			local trevj = require("trevj")
			trevj.setup()
			require("which-key").register({ K = { trevj.format_at_cursor, "Split" } })
		end,
	},
	{
		"kiran94/s3edit.nvim",
		cmd = "S3Edit",
		opts = {
			-- exclude = { ".git", ".hoodie", ".parquet", ".zip" },
			autocommand_events = { "BufWritePost" },
		},
	},
	-- Broken, revisit when updated
	-- { 'nvim-zh/colorful-winsep.nvim' },
	-- Embed Neovim in Chrome, Firefox & others.
	{
		"glacambre/firenvim",
		cond = not not vim.g.started_by_firenvim,
		build = require("plugins.firenvim").build,
		config = require("plugins.firenvim").config,
	},
	{
		"gen740/SmoothCursor.nvim",
		opts = require("plugins.smooth-cursor").opts,
	},
	-- { 'stevearc/overseer.nvim' },
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({ stages = "static" })
		end,
	},
	{
		"kwkarlwang/bufjump.nvim",
		keys = { "<C-n>", "<C-p>" },
		opts = {
			forward = "<C-n>",
			backward = "<C-p>",
			on_success = nil,
		},
	},
}, {
	-- diff = 'browser',
	-- diff = 'git',
	-- diff = 'diffview.nvim',
})

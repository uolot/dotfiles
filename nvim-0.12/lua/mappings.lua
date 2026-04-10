-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation --------------------

map("n", "<C-h>", "<C-w><C-h>", { remap = true })
map("n", "<C-l>", "<C-w><C-l>", { remap = true })
map("n", "<C-j>", "<C-w><C-j>", { remap = true })
map("n", "<C-k>", "<C-w><C-k>", { remap = true })

map("n", "<Tab>", "<C-w>w", { remap = true })
map("n", "<S-Tab>", "<C-w>W", { remap = true })

-- Buffer navigation --------------------

map("n", "<Backspace>", "<C-^>", { desc = "Last buffer" })
map("n", "gb", "<Cmd>bn<CR>", { silent = true, desc = "Next buffer" })
map("n", "gB", "<Cmd>bp<CR>", { silent = true, desc = "Previous buffer" })

-- Selection --------------------

map("n", "gV", "`[v`]", { silent = true, desc = "Select inserted/pasted text" })

-- Misc --------------------
map(
	"n",
	"go",
	":<C-u>put =repeat(nr2char(10), v:count1)<CR>",
	{ desc = "Insert blank lines below", remap = true, silent = true }
)
map(
	"n",
	"gO",
	":<C-u>put! =repeat(nr2char(10), v:count1)<CR>",
	{ desc = "Insert blank lines above", remap = true, silent = true, buffer = true }
)

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })

-- Better paste
map("v", "p", '"_dP', opts)

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Local leader --------------------
map("n", "<localleader>n", "<Cmd>enew<CR>", { desc = "New buffer" })
map("n", "<localleader>bn", "<Cmd>enew<CR>", { desc = "New buffer" })
map("n", "<localleader>by", ":let @+=expand('%:~:.')<CR>", { desc = "Yank relative path" })
map("n", "<localleader>bY", ":let @+=expand('%:p:~')<CR>", { desc = "Yank absolute path" })
-- yank/paste
map({ "n", "v" }, "<localleader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<localleader>p", '"+p', { desc = "Paste from system clipboard after cursor" })
map("n", "<localleader>P", '"+P', { desc = "Paste from system clipboard before cursor" })

local wk = require("which-key")

local function close_floating()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    -- if config.relative == 'win' then
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

local function next_diagnostic()
  vim.diagnostic.goto_next({ wrap = false })
end

local function prev_diagnostic()
  vim.diagnostic.goto_prev({ wrap = false })
end

wk.add({
  mode = "n",
  { "<Esc>",       close_floating, desc = "Close all floating windows" },
  { "<Backspace>", "<C-^>",        desc = "Quick buffer switch" },
  { "<Tab>",       "<C-w>w",       desc = "Next window" },
  { -- move
    { "<C-h>", "<C-w>h", desc = "Move left" },
    { "<C-j>", "<C-w>j", desc = "Move down" },
    { "<C-k>", "<C-w>k", desc = "Move up" },
    { "<C-l>", "<C-w>l", desc = "Move right" },
  },
  {
    noremap = true,
    silent = true,
    { -- jump to diagnostic
      { "]d", next_diagnostic, desc = "Go to next diagnostic" },
      { "[d", prev_diagnostic, desc = "Go to previous diagnostic" },
    },
    { -- search
      { "\\c", "/\\c",                          desc = "Case insensitive search", silent = false },
      { "\\s", "/\\<\\><left><left>",           desc = "Search for word",         silent = false },
      { "n",   "(v:searchforward ? 'n' : 'N')", expr = true },
      { "N",   "(v:searchforward ? 'N' : 'n')", expr = true },
    },
    { -- quickfix
      { "]q", "<Cmd>cnext<CR>" },
      { "[q", "<Cmd>cprev<CR>" },
    },
    { -- todo comments
      { "]t", require("todo-comments").jump_next },
      { "[t", require("todo-comments").jump_prev },
    },
  }
}, {
  mode = "x",
  noremap = true,
  silent = true,
  { "<", "<gv",        desc = "Indent left" },
  { ">", ">gv",        desc = "Indent right" },
  { ".", ":norm.<CR>", desc = "Make dot work in visual" },
})

require("mappings.g")
require("mappings.z")
require("mappings.c-w")
require('mappings.leader-c')
require('mappings.leader-d')
require('mappings.leader-f')
require('mappings.leader-g')
require("mappings.leader-h")
require("mappings.leader-k")
require("mappings.leader-n")
require("mappings.leader-r")
require("mappings.leader-t")
require("mappings.leader-s-t")
require("mappings.leader-x")

-- jest
vim.cmd([[nnoremap <silent> [j ?^\s*\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\\|beforeAll\\|afterAll\)\><CR>]])
vim.cmd([[nnoremap <silent> ]j /^\s*\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\\|beforeAll\\|afterAll\)\><CR>]])

local wk = require("which-key")
local snacks = require("snacks")
local treesj = require('treesj')

local function close_floating()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    -- if config.relative == 'win' then
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

local function next_usage()
  snacks.words.jump(1, true)
end

local function previous_usage()
  snacks.words.jump(-1, true)
end

wk.add({
  mode = "n",
  { "<Esc>",       close_floating, desc = "Close all floating windows" },
  { "<Backspace>", "<C-^>",        desc = "Quick buffer switch" },
  { "<Tab>",       "<C-w>w",       desc = "Next window" },
  { -- move
    { "<C-h>",    "<C-w>h", desc = "Move left" },
    { "<C-j>",    "<C-w>j", desc = "Move down" },
    { "<C-k>",    "<C-w>k", desc = "Move up" },
    { "<C-l>",    "<C-w>l", desc = "Move right" },
    { mode = "t", "<C-,>",  Snacks.terminal.toggle, desc = "Exit terminal mode" },
  },
  -- Snacks
  { "<C-,>",     Snacks.terminal.toggle,                                  desc = "Toggle terminal" },
  { "<Leader>.", function() Snacks.scratch.open({ ft = "markdown" }) end, desc = "Open scratch window" },
  { "<Leader>/", Snacks.scratch.select,                                   desc = "Select scratch window" },
  {
    mode = { "n", "x" },
    { "K", treesj.toggle, desc = "Split/join", },
  },
  -- Jumps
  {
    noremap = true,
    silent = true,
    { -- search
      { "\\c", "/\\c",                              desc = "Case insensitive search", silent = false },
      { "\\s", "/\\<\\><left><left>",               desc = "Search for word",         silent = false },
      { "n",   "(v:searchforward ? 'nzz' : 'Nzz')", expr = true },
      { "N",   "(v:searchforward ? 'Nzz' : 'nzz')", expr = true },
    },
    { -- todo comments
      { "[t", require("todo-comments").jump_prev, desc = "Previous todo comment" },
      { "]t", require("todo-comments").jump_next, desc = "Next todo comment" },
    },
    { -- lsp next/prev
      { "[n", previous_usage, desc = "Previous usage" },
      { "]n", next_usage,     desc = "Next usage" },
    },
    { -- aerial outline symbols
      { "[s", '<Cmd>AerialPrev<CR>', desc = "Previous symbol" },
      { "]s", '<Cmd>AerialNext<CR>', desc = "Next symbol" },
    },
    { -- treesitter scope from snacks
      { "[%", Snacks.scope.jump,                                   desc = "Scope top" },
      { "]%", function() Snacks.scope.jump({ bottom = true }) end, desc = "Scope bottom" },
    },
  },
})

require("mappings.g")
require("mappings.z")
require("mappings.c-w")
require('mappings.leader-a')
require('mappings.leader-c')
require('mappings.leader-f')
require('mappings.leader-g')
require("mappings.leader-h")
require("mappings.leader-k")
require("mappings.leader-l")
require("mappings.leader-n")
require("mappings.leader-t")
require("mappings.leader-s-t")
require("mappings.leader-x")
require("mappings.localleader")
require("mappings.ft.markdown")

-- jest
vim.cmd([[nnoremap <silent> [j ?^\s*\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\\|beforeAll\\|afterAll\)\><CR>]])
vim.cmd([[nnoremap <silent> ]j /^\s*\<\(it\\|test\\|describe\\|beforeEach\\|afterEach\\|beforeAll\\|afterAll\)\><CR>]])

vim.cmd([[vnoremap <silent> < <gv]])
vim.cmd([[vnoremap <silent> > >gv]])

local wk = require("which-key")

local function vim_opt_toggle(opt, on, off)
  local message = opt
  if vim.opt[opt]:get() == off then
    vim.opt[opt] = on
    message = "Set " .. message .. " to " .. vim.inspect(on)
  else
    vim.opt[opt] = off
    message = "Set " .. message .. " to " .. vim.inspect(off)
  end
  vim.notify(message)
end

local function toggle_diagnostic()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify("Disabled diagnostics")
  else
    vim.diagnostic.enable()
    vim.notify("Enabled diagnostics")
  end
end

local function toggle_inlay_hints()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 }) -- try getting bufnr from `buffer` if this doesn't work

  if enabled then
    vim.notify("Disabled inlay hints")
  else
    vim.notify("Enabled inlay hints")
  end
end

-- b = { function() vim_opt_toggle("background", "light", "dark") end, "Background" },

wk.add({
  { "<Leader>x",  group = "Toggles" },
  { "<Leader>xb", function() require("bamboo").toggle() end,                    desc = "Background" },
  { "<Leader>xd", toggle_diagnostic,                                            desc = "Diagnostics" },
  -- moved to lsp config
  -- { "<Leader>xi", toggle_inlay_hints,                                           desc = "Inlay hints" },
  { "<Leader>xr", function() vim_opt_toggle("relativenumber", true, false) end, desc = "Relative number" },
  { "<Leader>xw", function() vim_opt_toggle("wrap", true, false) end,           desc = "Line wrap" },
})

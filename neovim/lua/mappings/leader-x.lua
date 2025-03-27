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

local function toggle_formatting()
  if vim.b.disable_autoformat then
    vim.b.disable_autoformat = false
    vim.notify("Enabled buffer formatting")
  else
    vim.b.disable_autoformat = true
    vim.notify("Disabled buffer formatting")
  end
end

wk.add({
  { "<Leader>x",  group = "Toggles" },
  { "<Leader>xb", function() require("bamboo").toggle() end,                    desc = "Background" },
  { "<Leader>xd", toggle_diagnostic,                                            desc = "Diagnostics" },
  { "<Leader>xf", toggle_formatting,                                            desc = "Formatting" },
  { "<Leader>xr", function() vim_opt_toggle("relativenumber", true, false) end, desc = "Relative number" },
  { "<Leader>xw", function() vim_opt_toggle("wrap", true, false) end,           desc = "Line wrap" },
})

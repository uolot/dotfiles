local wez = require('wezterm')

local font_family = 'BlexMono Nerd Font Mono'
local color_scheme = 'GitHub Dark'

-- Show which key table is active in the status area
wez.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

local config = {
  -- appearance
  use_fancy_tab_bar = false,
  enable_scroll_bar = false,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  window_decorations = "TITLE | RESIZE",
  inactive_pane_hsb = { saturation = 0.9, brightness = 1.8 },

  -- font
  font = wez.font { family = font_family, weight = 'Regular' },
  freetype_load_target = 'Light',
  font_size = 15,
  line_height = 1.2,
  font_rules = {
    {
      intensity = 'Half',
      italic = false,
      font = wez.font { family = font_family, weight = 'Light', italic = false },
    },
    {
      intensity = 'Half',
      italic = true,
      font = wez.font { family = font_family, weight = 'Light', italic = true },
    },
    {
      intensity = 'Bold',
      italic = false,
      font = wez.font { family = font_family, weight = 'Medium', italic = false },
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wez.font { family = font_family, weight = 'Medium', italic = true },
    },
  },

  -- colors
  color_scheme = color_scheme,
  colors = {
    split = '#bbbbbb',
  },

  -- available keys
  -- ..e..yui..
  -- a.dfg....
  -- zxc.b..

  -- keys
  leader = { key = 'w', mods = 'CMD', timeout_milliseconds = 1000 },
  keys = {
    -- splits
    {
      key = 'v',
      mods = 'LEADER',
      action = wez.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 's',
      mods = 'LEADER',
      action = wez.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- move between panes
    {
      key = 'h',
      mods = 'LEADER',
      action = wez.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = wez.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = wez.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = wez.action.ActivatePaneDirection 'Right',
    },
    -- activate pane mode
    {
      key = 'm',
      mods = 'LEADER',
      action = wez.action.ActivateKeyTable {
        name = 'activate_pane',
        one_shot = false,
        timeout_milliseconds = 2000,
      }
    },
    -- select pane
    {
      key = 'p',
      mods = 'LEADER',
      action = wez.action.PaneSelect,
    },
    -- swap with pane
    {
      key = 'w',
      mods = 'LEADER',
      action = wez.action.PaneSelect { mode = 'SwapWithActive' },
    },
    -- rotate panes
    {
      key = 'o',
      mods = 'LEADER',
      action = wez.action.RotatePanes 'Clockwise',
    },
    -- resize pane
    {
      key = 'h',
      mods = 'LEADER|SHIFT',
      action = wez.action.AdjustPaneSize { 'Left', 5 },
    },
    {
      key = 'j',
      mods = 'LEADER|SHIFT',
      action = wez.action.AdjustPaneSize { 'Down', 5 },
    },
    {
      key = 'k',
      mods = 'LEADER|SHIFT',
      action = wez.action.AdjustPaneSize { 'Up', 5 }
    },
    {
      key = 'l',
      mods = 'LEADER|SHIFT',
      action = wez.action.AdjustPaneSize { 'Right', 5 },
    },
    -- resize pane mode
    {
      key = 'r',
      mods = 'LEADER',
      action = wez.action.ActivateKeyTable {
        name = 'resize_pane',
        one_shot = false,
        -- timeout_milliseconds = 1000,
      }
    },
    -- close pane
    {
      key = 'q',
      mods = 'LEADER',
      action = wez.action.CloseCurrentPane({ confirm = false }),
    },
    -- move between tabs
    {
      key = 'n',
      mods = 'LEADER',
      action = wez.action.ActivateTabRelative(1),
    },
    {
      key = 'n',
      mods = 'LEADER|SHIFT',
      action = wez.action.ActivateTabRelative(-1),
    },
    -- new tab
    {
      key = 't',
      mods = 'LEADER',
      action = wez.action.SpawnTab 'CurrentPaneDomain',
    },
    -- move tabs
    {
      key = '>',
      mods = 'LEADER',
      action = wez.action.MoveTabRelative(1),
    },
    {
      key = '<',
      mods = 'LEADER',
      action = wez.action.MoveTabRelative(-1),
    },
    -- override hiding the window
    {
      key = 'h',
      mods = 'CMD',
      action = wez.action.Nop,
    },
  },

  key_tables = {
    activate_pane = {
      { key = 'LeftArrow',  action = wez.action.ActivatePaneDirection 'Left' },
      { key = 'h',          action = wez.action.ActivatePaneDirection 'Left' },
      { key = 'RightArrow', action = wez.action.ActivatePaneDirection 'Right' },
      { key = 'l',          action = wez.action.ActivatePaneDirection 'Right' },
      { key = 'UpArrow',    action = wez.action.ActivatePaneDirection 'Up' },
      { key = 'k',          action = wez.action.ActivatePaneDirection 'Up' },
      { key = 'DownArrow',  action = wez.action.ActivatePaneDirection 'Down' },
      { key = 'j',          action = wez.action.ActivatePaneDirection 'Down' },

      -- Cancel the mode by pressing escape, enter, or Q
      { key = 'q',          action = 'PopKeyTable' },
      { key = 'Escape',     action = 'PopKeyTable' },
      { key = 'Enter',      action = 'PopKeyTable' },
    },

    resize_pane = {
      { key = 'LeftArrow',  mods = '',      action = wez.action.AdjustPaneSize { 'Left', 1 } },
      { key = 'h',          mods = '',      action = wez.action.AdjustPaneSize { 'Left', 1 } },
      { key = 'h',          mods = 'SHIFT', action = wez.action.AdjustPaneSize { 'Left', 10 } },
      { key = 'RightArrow', mods = '',      action = wez.action.AdjustPaneSize { 'Right', 1 } },
      { key = 'l',          mods = '',      action = wez.action.AdjustPaneSize { 'Right', 1 } },
      {
        key = 'l',
        mods = 'SHIFT',
        action = wez.action.AdjustPaneSize {
          'Right', 10 }
      },
      { key = 'UpArrow',   mods = '',             action = wez.action.AdjustPaneSize { 'Up', 1 } },
      { key = 'k',         mods = '',             action = wez.action.AdjustPaneSize { 'Up', 1 } },
      { key = 'k',         mods = 'SHIFT',        action = wez.action.AdjustPaneSize { 'Up', 10 } },
      { key = 'DownArrow', mods = '',             action = wez.action.AdjustPaneSize { 'Down', 1 } },
      { key = 'j',         mods = '',             action = wez.action.AdjustPaneSize { 'Down', 1 } },
      { key = 'j',         mods = 'SHIFT',        action = wez.action.AdjustPaneSize { 'Down', 10 } },

      -- Cancel the mode by pressing escape or Q
      { key = 'q',         action = 'PopKeyTable' },
      { key = 'Escape',    action = 'PopKeyTable' },
    },

  },
}

-- select tab
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wez.action.ActivateTab(i - 1),
  })
end

-- hyperlink rules
config.hyperlink_rules = wez.default_hyperlink_rules()

-- Jira CD/CDA
table.insert(config.hyperlink_rules, {
  regex = [[\b(CDA?-\d+)\b]],
  format = 'https://legogroup.atlassian.net/browse/$1',
})

-- cd-monorepo Github PR
table.insert(config.hyperlink_rules, {
  regex = [[#(\d+)]],
  format = 'https://github.com/LEGO/cd-monorepo/pull/$1',
})

-- cd-monorepo commit
table.insert(config.hyperlink_rules, {
  regex = [[([0-9a-f]{7})]],
  format = 'https://github.com/LEGO/cd-monorepo/commit/$1',
})

-- Github user/repo in quotes
table.insert(config.hyperlink_rules, {
  regex = [[([\w\d]{1}[-\w\d]+)/([-\w\d\.]+)]],
  format = 'https://www.github.com/$1/$3',
})

return config;

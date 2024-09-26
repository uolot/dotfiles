-- 01_TOC
-- 02_keys
-- 10_appearance
-- 20_font
-- 30_colors
-- 40_keys
--   41_available_keys
--     411_leader
--   42_key_bindings
--     421_splits
--     422_move_between_panes
--     423_activate_pane_mode -> 51_activate_pane
--     424_select_pane
--     425_swap_with_pane
--     426_rotate_panes
--     428_resize_pane_mode -> 52_resize_pane
--     429_close_pane
--     430_promote_pane_to_tab
--     431_promote_pane_to_window
--     432_new_tab
--     433_move_tabs
--     434_override_hiding_the_window
--     435_command_palette
--     436_activate_copy_mode
--     437_activate_quick_select_mode
--     438_activate_quick_select_url_mode
--     439_activate_next_pane
--     440_balance_panes
--     441_toggle_bottom_pane
--     442_toggle_right_pane
-- 50_key_tables
-- 51_activate_pane
-- 52_resize_pane
-- 60_select_tab_keymaps
-- 70_hyperlink_rules

-- 02_keys:

-- Splits
--   LEADER-v: Split Horizontal
--   LEADER-s: Split Vertical

-- Pane navigation
--   LEADER-p: Select Pane
--   LEADER-n: Activate Next Pane
--   LEADER-h: Activate Left Pane
--   LEADER-j: Activate Right Pane
--   LEADER-k: Activate Up Pane
--   LEADER-l: Activate Down Pane
--   LEADER-m: Enter Activate Pane Mode
--       h: Activate Left Pane
--       l: Activate Right Pane
--       k: Activate Up Pane
--       j: Activate Down Pane

-- Pane management
--   LEADER-x: Select Pane To Swap With
--   LEADER-o: Rotate Panes Clockwise
--   LEADER-q: Close Current Pane
--   LEADER-SHIFT-t: Move Pane To A New Tab
--   LEADER-SHIFT-w: Move Pane To A New Window

-- Pane resizing
--   LEADER-b: Balance panes
--   LEADER-r: Activate Resize Pane Mode
--       h: Resize Left 1
--       SHIFT-h: Resize Left 10
--       CTRL-h: Resize Left 50
--       l: Resize Right 1
--       SHIFT-l: Resize Right 10
--       CTRL-l: Resize Right 50
--       k: Resize Up 1
--       SHIFT-k: Resize Up 10
--       CTRL-k: Resize Up 50
--       j: Resize Down 1
--       SHIFT-j: Resize Down 10
--       CTRL-j: Resize Down 50

-- Tabs
--   LEADER-t: Open New Tab
--   LEADER->: Switch To Next Tab
--   LEADER-<: Switch To Previous Tab
--   LEADER-1: Switch To Tab 0
--   LEADER-2: Switch To Tab 1
--   LEADER-3: Switch To Tab 2
--   LEADER-4: Switch To Tab 3
--   LEADER-5: Switch To Tab 4
--   LEADER-6: Switch To Tab 5
--   LEADER-7: Switch To Tab 6
--   LEADER-8: Switch To Tab 7

-- Selection
--   LEADER-c: Activate Copy Mode
--   LEADER-y: Start Quick Select
--   LEADER-u: Quick Select URL

-- Misc
--   LEADER-Space: Activate Command Palette
--   CMD-h: Nop

local wez = require('wezterm')
local balance = require('balance')

-- local font_family = 'BlexMono Nerd Font Mono'
local font_family = 'MesloLGL Nerd Font Mono'

-- local color_scheme = 'GitHub Dark'
local color_scheme = 'Bamboo Multiplex'

-- Show which key table is active in the status area
wez.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

local config = {
  -- 10_appearance
  use_fancy_tab_bar = false,
  enable_scroll_bar = false,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  window_decorations = "TITLE | RESIZE",
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.6,
  },

  -- 20_font
  font = wez.font { family = font_family, weight = 'Regular' },
  freetype_load_target = 'Light',
  -- font_size = 14.5,
  font_size = 15,
  -- line_height = 1.3,
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

  -- 30_colors

  color_scheme = color_scheme,
  colors = {
    -- split = '#bbbbbb',
    -- split = '#ffa500', -- orange from janky borders
    split = '#C07100',
  },

  -- 40_keys

  -- 41_available_keys

  -- 411_leader
  -- .we....i..
  -- a.dfg....
  -- z......

  -- 42_key_bindings
  leader = { key = 'w', mods = 'CMD', timeout_milliseconds = 1000 },

  keys = {
    -- 421_splits
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
    -- 422_move_between_panes
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
    {
      key = 'h',
      mods = 'CMD',
      action = wez.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'CMD',
      action = wez.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'CMD',
      action = wez.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'CMD',
      action = wez.action.ActivatePaneDirection 'Right',
    },
    -- 423_activate_pane_mode -> 51_activate_pane
    {
      key = 'm',
      mods = 'LEADER',
      action = wez.action.ActivateKeyTable {
        name = 'activate_pane',
        one_shot = false,
        timeout_milliseconds = 2000,
      }
    },
    -- 424_select_pane
    {
      key = 'p',
      mods = 'LEADER',
      action = wez.action.PaneSelect,
    },
    -- 425_swap_with_pane
    {
      key = 'x',
      mods = 'LEADER',
      action = wez.action.PaneSelect { mode = 'SwapWithActive' },
    },
    -- 426_rotate_panes
    {
      key = 'o',
      mods = 'LEADER',
      action = wez.action.RotatePanes 'Clockwise',
    },
    -- 428_resize_pane_mode -> 52_resize_pane
    {
      key = 'r',
      mods = 'LEADER',
      action = wez.action.ActivateKeyTable {
        name = 'resize_pane',
        one_shot = false,
        -- timeout_milliseconds = 1000,
      }
    },
    -- 429_close_pane
    {
      key = 'q',
      mods = 'LEADER',
      action = wez.action.CloseCurrentPane({ confirm = false }),
    },
    -- 430_promote_pane_to_tab
    {
      key = "t",
      mods = "LEADER | SHIFT",
      action = wez.action_callback(
        function(win, pane)
          pane:move_to_new_tab()
        end)
    },
    -- 431_promote_pane_to_window
    {
      key = "w",
      mods = "LEADER | SHIFT",
      action = wez.action_callback(
        function(win, pane)
          pane:move_to_new_window()
        end)
    },
    -- 432_new_tab
    {
      key = 't',
      mods = 'LEADER',
      action = wez.action.SpawnTab 'CurrentPaneDomain',
    },
    -- 433_move_tabs
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
    -- 434_override_hiding_the_window
    -- {
    --   key = 'h',
    --   mods = 'CMD',
    --   action = wez.action.Nop,
    -- },
    -- 435_command_palette
    {
      key = 'Space',
      mods = 'LEADER',
      action = wez.action.ActivateCommandPalette,
    },
    -- 436_activate_copy_mode
    {
      key = 'c',
      mods = 'LEADER',
      action = wez.action.ActivateCopyMode,
    },
    -- 437_activate_quick_select_mode
    {
      key = 'y',
      mods = 'LEADER',
      action = wez.action.QuickSelect,
    },
    -- 438_activate_quick_select_url_mode
    {
      key = 'u',
      mods = 'LEADER',
      action = wez.action.QuickSelectArgs {
        patterns = {
          'https?://\\S+',
        },
      }
    },
    -- 439_activate_next_pane
    {
      key = 'n',
      mods = 'LEADER',
      action = wez.action.ActivatePaneDirection 'Next',
    },
    -- 440_balance_panes
    {
      key = 'b',
      mods = 'LEADER',
      action = wez.action.Multiple {
        wez.action_callback(balance.balance_panes("x")),
        wez.action_callback(balance.balance_panes("y")),
      },
    },
    -- 441_toggle_bottom_pane
    {
      key = ",",
      mods = 'CMD',
      action = wez.action_callback(function(_, pane)
        local tab = pane:tab()
        local panes = tab:panes_with_info()
        if #panes == 1 then
          pane:split({
            direction = "Bottom",
            size = 0.4,
          })
        elseif not panes[1].is_zoomed then
          panes[1].pane:activate()
          tab:set_zoomed(true)
        elseif panes[1].is_zoomed then
          tab:set_zoomed(false)
          panes[2].pane:activate()
        end
      end),
    },
    -- 442_toggle_right_pane
    {
      key = ";",
      mods = 'CMD',
      action = wez.action_callback(function(_, pane)
        local tab = pane:tab()
        local panes = tab:panes_with_info()
        if #panes == 1 then
          pane:split({
            direction = "Right",
            size = 0.3,
          })
        elseif not panes[1].is_zoomed then
          panes[1].pane:activate()
          tab:set_zoomed(true)
        elseif panes[1].is_zoomed then
          tab:set_zoomed(false)
          panes[2].pane:activate()
        end
      end),
    },
  },

  -- 50_key_tables
  key_tables = {
    -- 51_activate_pane
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

    -- 52_resize_pane
    resize_pane = {
      { key = 'h',      mods = '',             action = wez.action.AdjustPaneSize { 'Left', 10 } },
      { key = 'h',      mods = 'SHIFT',        action = wez.action.AdjustPaneSize { 'Left', 50 } },
      { key = 'h',      mods = 'CTRL',         action = wez.action.AdjustPaneSize { 'Left', 1 } },
      { key = 'l',      mods = '',             action = wez.action.AdjustPaneSize { 'Right', 10 } },
      { key = 'l',      mods = 'SHIFT',        action = wez.action.AdjustPaneSize { 'Right', 50 } },
      { key = 'l',      mods = 'CTRL',         action = wez.action.AdjustPaneSize { 'Right', 1 } },
      { key = 'k',      mods = '',             action = wez.action.AdjustPaneSize { 'Up', 4 } },
      { key = 'k',      mods = 'SHIFT',        action = wez.action.AdjustPaneSize { 'Up', 20 } },
      { key = 'k',      mods = 'CTRL',         action = wez.action.AdjustPaneSize { 'Up', 1 } },
      { key = 'j',      mods = '',             action = wez.action.AdjustPaneSize { 'Down', 4 } },
      { key = 'j',      mods = 'SHIFT',        action = wez.action.AdjustPaneSize { 'Down', 20 } },
      { key = 'j',      mods = 'CTRL',         action = wez.action.AdjustPaneSize { 'Down', 1 } },

      -- Cancel the mode by pressing escape or Q
      { key = 'q',      action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'Enter',  action = 'PopKeyTable' },
    },

  },
}

-- 60_select_tab_keymaps
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wez.action.ActivateTab(i - 1),
  })
end

-- 70_hyperlink_rules

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
-- table.insert(config.hyperlink_rules, {
--   regex = [[([0-9a-f]{7})]],
--   format = 'https://github.com/LEGO/cd-monorepo/commit/$1',
-- })

-- -- Github user/repo in quotes
-- table.insert(config.hyperlink_rules, {
--   regex = [[([\w\d]{1}[-\w\d]+)/([-\w\d\.]+)]],
--   format = 'https://www.github.com/$1/$3',
-- })

return config;

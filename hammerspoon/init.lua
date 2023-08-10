-- http://www.hammerspoon.org/docs/

-- TODO: add a function for flashing current window

-- https://github.com/mengelbrecht/hammerspoon-config/blob/main/init.lua#L129
-- local teamsID = "com.microsoft.teams"
local teamsID = "microsoft.teams"
local itermID = "com.googlecode.iterm2"
-- local outlookID = "com.microsoft.outlook"

local mouseCircleConfig = {
    radius = 40,
    color = { red = 1, blue = 0, green = 0, alpha = 0.4 },
    fill = true,
    strokeWidth = 5,
    duration = 0.4,
}

hs.window.animationDuration = 0

-- debug print:
-- hs.console.printStyledtext(hs.inspect.inspect(obj))

local function focused()
    return hs.window.focusedWindow()
end

local function toggleTeamsMute()
    local teams = hs.application.find(teamsID)
    -- hs.application.findWindow(titlePattern)
    if not (teams == null) then
        hs.eventtap.keyStroke({ "cmd", "shift" }, "m", 50, teams)
    end
end

local function startIterm()
    -- XXX: try hs.application.launchOrFocus(itermID)
    local iterm = hs.application.find(itermID)
    if not (iterm == null) then
        hs.eventtap.keyStroke({ "cmd" }, "n", 0, iterm)
    end
end

local function moveWindowToPreviousScreen()
    local window = focused()
    local screen = window:screen():previous()
    if not (screen == nil) then
        window:moveToScreen(screen)
    end
end

local function moveWindowToNextScreen()
    local window = focused()
    local screen = window:screen():next()
    if not (screen == nil) then
        window:moveToScreen(screen)
    end
end

local mouseCircle = nil
local mouseCircleTimer = nil

local function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        mouseCircle = nil
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    local mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    local r = mouseCircleConfig.radius
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x - r, mousepoint.y - r, 2 * r, 2 * r))
    mouseCircle:setStrokeColor(mouseCircleConfig.color)
    mouseCircle:setFillColor(mouseCircleConfig.color)
    mouseCircle:setFill(mouseCircleConfig.fill)
    mouseCircle:setStrokeWidth(mouseCircleConfig.strokeWidth)
    mouseCircle:show()

    -- Set a timer to delete the circle after 0.4 second
    mouseCircleTimer = hs.timer.doAfter(mouseCircleConfig.duration,
        function()
            mouseCircle:delete(); mouseCircle = nil
        end)
end

local function yabai(args)
    -- hs.task.new("/usr/local/bin/yabai", nil, function(...)
    hs.task.new("/opt/homebrew/bin/yabai", nil, function(...)
        print("stream", hs.inspect(table.pack(...)))
        return true
    end, args):start()
end

-- local function warpd(args)
--     hs.task.new("/usr/local/bin/warpd", nil, function (...)
--         print("stream", hs.inspect(table.pack(...)))
--         return true
--     end, args):start()
-- end
--
local hyper = { "cmd", "alt", "ctrl", "shift" }
local meh = { "alt", "ctrl", "shift" }

-- HYPER

-- mapped keys
-- . . . R T Y U . . .
-- A . D F G . . . . ;
-- Z X . V B . . x x /

-- Apps
-- hs.hotkey.bind(hyper, "p", toggleTeamsMute)
-- hs.hotkey.bind(hyper, "i", startIterm)

-- Window navigation
-- hs.hotkey.bind(hyper, ";", hs.hints.windowHints)
hs.hotkey.bind(hyper, "return", function() yabai({ '-m', 'window', '--toggle', 'zoom-fullscreen' }) end)
hs.hotkey.bind(hyper, "space", function() yabai({ '-m', 'window', '--toggle', 'float' }) end)

-- hs.hotkey.bind(hyper, "q", function() hs.grid.setGrid("1x1") end)
-- hs.hotkey.bind(hyper, "w", function() hs.grid.setGrid("2x1") end)
-- hs.hotkey.bind(hyper, "e", function() hs.grid.setGrid("3x1") end)

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

-- hs.hotkey.bind(hyper, "y", function() hs.grid.pushWindowLeft() end)
-- hs.hotkey.bind(hyper, "u", function() hs.grid.pushWindowRight() end)

-- hs.hotkey.bind(hyper, "s", function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(hyper, "c", function() hs.window.focusedWindow():centerOnScreen() end)

hs.hotkey.bind(hyper, "h", function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(hyper, "j", function() hs.window.focusedWindow():focusWindowSouth() end)
hs.hotkey.bind(hyper, "k", function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyper, "l", function() hs.window.focusedWindow():focusWindowEast() end)

-- hs.hotkey.bind(hyper, "h", function() yabai({ '-m', 'window', '--focus', 'west' }) end)
-- hs.hotkey.bind(hyper, "j", function() yabai({ '-m', 'window', '--focus', 'south' }) end)
-- hs.hotkey.bind(hyper, "k", function() yabai({ '-m', 'window', '--focus', 'north' }) end)
-- hs.hotkey.bind(hyper, "l", function() yabai({ '-m', 'window', '--focus', 'east' }) end)

hs.hotkey.bind(hyper, "n", function() yabai({ '-m', 'window', '--space', 'next' }) end)
hs.hotkey.bind(hyper, "p", function() yabai({ '-m', 'window', '--space', 'prev' }) end)

hs.hotkey.bind(hyper, "right", function() yabai({ '-m', 'display', '--focus', 'next' }) end)
hs.hotkey.bind(hyper, "left", function() yabai({ '-m', 'display', '--focus', 'prev' }) end)

-- hs.hotkey.bind(hyper, "z", function () warpd({'--hint'}) end)
-- hs.hotkey.bind(hyper, "x", function () warpd({'--grid'}) end)
-- hs.hotkey.bind(hyper, "c", function () warpd({'--normal'}) end)

-- grow
-- hs.hotkey.bind(hyper, "e", function () yabai({'-m', 'window', '--resize', 'top:0:-200'}) end)
-- hs.hotkey.bind(hyper, "s", function () yabai({'-m', 'window', '--resize', 'left:-200:0'}) end)
-- hs.hotkey.bind(hyper, "d", function () yabai({'-m', 'window', '--resize', 'bottom:0:200'}) end)
-- hs.hotkey.bind(hyper, "f", function () yabai({'-m', 'window', '--resize', 'right:200:0'}) end)

-- Mouse
-- TODO:
-- hs.hotkey.bind(hyper, "m", leftMouseClick)
hs.hotkey.bind(hyper, "m", mouseHighlight)

-- MEH

-- mapped keys
-- Q W E . T . U I O .
-- A . D F . G . . . ;
-- Z . C V . . M x x /

hs.hotkey.bind(meh, "h", function() yabai({ '-m', 'window', '--swap', 'west' }) end)
hs.hotkey.bind(meh, "j", function() yabai({ '-m', 'window', '--swap', 'south' }) end)
hs.hotkey.bind(meh, "k", function() yabai({ '-m', 'window', '--swap', 'north' }) end)
hs.hotkey.bind(meh, "l", function() yabai({ '-m', 'window', '--swap', 'east' }) end)

hs.hotkey.bind(meh, "space", function() yabai({ '-m', 'window', '--toggle', 'float', '--grid', '6:4:1:1:2:4' }) end)
hs.hotkey.bind(meh, "s", function() yabai({ '-m', 'window', '--toggle', 'sticky' }) end)

hs.hotkey.bind(meh, "b", function() yabai({ '-m', 'space', '--balance' }) end)
hs.hotkey.bind(meh, "r", function() yabai({ '-m', 'space', '--rotate', '270' }) end)
hs.hotkey.bind(meh, "x",
    function()
        yabai({ '-m', 'space', '--mirror', 'x-axis' }); yabai({ '-m', 'space', '--balance' })
    end)
hs.hotkey.bind(meh, "y",
    function()
        yabai({ '-m', 'space', '--mirror', 'y-axis' }); yabai({ '-m', 'space', '--balance' })
    end)

hs.hotkey.bind(meh, "n", moveWindowToNextScreen)
hs.hotkey.bind(meh, "p", moveWindowToPreviousScreen)

-- shrink
-- hs.hotkey.bind(meh, "e", function () yabai({'-m', 'window', '--resize', 'top:0:200'}) end)
-- hs.hotkey.bind(meh, "s", function () yabai({'-m', 'window', '--resize', 'left:200:0'}) end)
-- hs.hotkey.bind(meh, "d", function () yabai({'-m', 'window', '--resize', 'bottom:0:-200'}) end)
-- hs.hotkey.bind(meh, "f", function () yabai({'-m', 'window', '--resize', 'right:-200:0'}) end)

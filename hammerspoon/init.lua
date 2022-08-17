-- http://www.hammerspoon.org/docs/

-- TODO: add a function for flashing current window

-- https://github.com/mengelbrecht/hammerspoon-config/blob/main/init.lua#L129
-- local teamsID = "com.microsoft.teams"
local teamsID = "microsoft.teams"
local itermID = "com.googlecode.iterm2"
-- local outlookID = "com.microsoft.outlook"

local mouseCircleConfig = {
    radius=40,
    color={red=1, blue=0, green=0, alpha=0.4},
    fill=true,
    strokeWidth=5,
    duration=0.4,
}

hs.window.animationDuration = 0

-- debug print:
-- hs.console.printStyledtext(hs.inspect.inspect(obj))

function focused()
    return hs.window.focusedWindow()
end

function toggleTeamsMute()
    local teams = hs.application.find(teamsID)
    -- hs.application.findWindow(titlePattern)
    if not (teams == null) then
        hs.eventtap.keyStroke({"cmd", "shift"}, "m", 50, teams)
    end
end

function startIterm()
    -- XXX: try hs.application.launchOrFocus(itermID)
    local iterm = hs.application.find(itermID)
    if not (iterm == null) then
        hs.eventtap.keyStroke({"cmd"}, "n", 0, iterm)
    end
end

local origWindowPos = {}
function maximizeCurrentWindow(small)
    local window = focused()
    local id = window:id()
    if not origWindowPos[id] then
        origWindowPos[id] = window:frame()
        if small then
            hs.grid.setGrid("10x8").set(focused(), "2,1 6x6")
        else
            window:maximize()
        end
    else
        window:setFrame(origWindowPos[id])
        origWindowPos[id] = nil
    end
    -- drawWindowBorder()
end

function moveWindowToPreviousScreen()
    local window = focused()
    local screen = window:screen():previous()
    if not (screen == nil) then
        window:moveToScreen(screen)
    end
end

function moveWindowToNextScreen()
    local window = focused()
    local screen = window:screen():next()
    if not (screen == nil) then
        window:moveToScreen(screen)
    end
end

local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
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
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-r, mousepoint.y-r, 2*r, 2*r))
    mouseCircle:setStrokeColor(mouseCircleConfig.color)
    mouseCircle:setFillColor(mouseCircleConfig.color)
    mouseCircle:setFill(mouseCircleConfig.fill)
    mouseCircle:setStrokeWidth(mouseCircleConfig.strokeWidth)
    mouseCircle:show()

    -- Set a timer to delete the circle after 0.4 second
    mouseCircleTimer = hs.timer.doAfter(mouseCircleConfig.duration, function() mouseCircle:delete(); mouseCircle = nil end)
end

function jumpToNextScreen()
    local nextScreen = hs.mouse.getCurrentScreen():next()
    if nextScreen == nil then hs.alert("no next screen"); return; end
    hs.mouse.absolutePosition(nextScreen:frame().center)
    mouseHighlight()
end

function jumpToPrevScreen()
    local nextScreen = hs.mouse.getCurrentScreen():previous()
    if nextScreen == nil then hs.alert("no next screen"); return; end
    hs.mouse.absolutePosition(nextScreen:frame().center)
    mouseHighlight()
end

function yabai(args)
    hs.task.new("/usr/local/bin/yabai", nil, function (...)
        print("stream", hs.inspect(table.pack(...)))
        return true
    end, args):start()
end

local hyper = {"cmd", "alt", "ctrl", "shift"}
local meh = {"alt", "ctrl", "shift"}

-- HYPER

-- mapped keys
-- . . . R . Y U . . .
-- . . . . . . . . . ;
-- . . C V B . . x x /

-- Apps
-- hs.hotkey.bind(hyper, "p", toggleTeamsMute)
hs.hotkey.bind(hyper, "i", startIterm)

-- Window navigation
-- hs.hotkey.bind(hyper, ";", hs.hints.windowHints)
hs.hotkey.bind(hyper, "return", maximizeCurrentWindow)
-- hs.hotkey.bind(hyper, "space", function() maximizeCurrentWindow(true) end)
hs.hotkey.bind(hyper, "space", function() yabai({'-m', 'window', '--resize', 'abs:1200:900'}) end)

-- hs.hotkey.bind(hyper, "h", function() focused():focusWindowWest() end)
-- hs.hotkey.bind(hyper, "j", function() focused():focusWindowSouth() end)
-- hs.hotkey.bind(hyper, "k", function() focused():focusWindowNorth() end)
-- hs.hotkey.bind(hyper, "l", function() focused():focusWindowEast() end)

hs.hotkey.bind(hyper, "h", function () yabai({'-m', 'window', '--focus', 'west'}) end)
hs.hotkey.bind(hyper, "j", function () yabai({'-m', 'window', '--focus', 'south'}) end)
hs.hotkey.bind(hyper, "k", function () yabai({'-m', 'window', '--focus', 'north'}) end)
hs.hotkey.bind(hyper, "l", function () yabai({'-m', 'window', '--focus', 'east'}) end)

hs.hotkey.bind(hyper, "n", moveWindowToNextScreen)
hs.hotkey.bind(hyper, "p", moveWindowToPreviousScreen)

hs.hotkey.bind(hyper, "right", function () yabai({'-m', 'display', '--focus', 'next'}) end)
hs.hotkey.bind(hyper, "left", function () yabai({'-m', 'display', '--focus', 'prev'}) end)

-- hs.hotkey.bind(hyper, "b", toggleWindowBorder)

-- Grid
hs.hotkey.bind(hyper, "g", function() hs.grid.setGrid("6x4"); hs.grid.show() end)
hs.hotkey.bind(hyper, "t", function() hs.grid.setGrid("8x4"); hs.grid.show() end)
hs.hotkey.bind(hyper, "q", function() hs.grid.setGrid("1x2"); hs.grid.show() end)
hs.hotkey.bind(hyper, "a", function() hs.grid.setGrid("3x1"); hs.grid.show() end)
hs.hotkey.bind(hyper, "z", function() hs.grid.setGrid("1x3"); hs.grid.show() end)
hs.hotkey.bind(hyper, "w", function() hs.grid.setGrid("8x1"); hs.grid.show() end)
hs.hotkey.bind(hyper, "s", function() hs.grid.setGrid("6x1"); hs.grid.show() end)
hs.hotkey.bind(hyper, "x", function()
    local hints = hs.grid.HINTS;
    hs.grid.HINTS = {
        {
            '1','2','3','4','5','6','7','8','9','0','Z','X'
        },
        {
            'Q','W','E','R','T','Y','U','I','O','P','A','S'
        },
    };
    hs.inspect(hs.grid.HINTS);
    hs.grid.setGrid("12x1");
    hs.inspect(hs.grid.HINTS);
    hs.grid.show();
    hs.grid.HINTS = hints;
end)

-- 2x1
hs.hotkey.bind(hyper, "d", function() hs.grid.setGrid("2x1").set(focused(), "0,0 1x1")  end)
hs.hotkey.bind(hyper, "f", function() hs.grid.setGrid("2x1").set(focused(), "1,0 1x1")  end)

-- Mouse
-- TODO:
-- hs.hotkey.bind(hyper, "m", leftMouseClick)
hs.hotkey.bind(hyper, "m", mouseHighlight)

-- MEH

-- mapped keys
-- Q W E . T . U I O .
-- A . D F . G . . . ;
-- Z . C V . . M x x /

hs.hotkey.bind(meh, "h", function () yabai({'-m', 'window', '--swap', 'west'}) end)
hs.hotkey.bind(meh, "j", function () yabai({'-m', 'window', '--swap', 'south'}) end)
hs.hotkey.bind(meh, "k", function () yabai({'-m', 'window', '--swap', 'north'}) end)
hs.hotkey.bind(meh, "l", function () yabai({'-m', 'window', '--swap', 'east'}) end)

hs.hotkey.bind(meh, "space", function () yabai({'-m', 'window', '--toggle', 'float'}) end)

hs.hotkey.bind(meh, "b", function () yabai({'-m', 'space', '--balance'}) end)
hs.hotkey.bind(meh, "r", function () yabai({'-m', 'space', '--rotate', '270'}) end)
hs.hotkey.bind(meh, "x", function () yabai({'-m', 'space', '--mirror', 'x-axis'}) end)
hs.hotkey.bind(meh, "y", function () yabai({'-m', 'space', '--mirror', 'y-axis'}) end)
hs.hotkey.bind(meh, "s", function () yabai({'-m', 'window', '--toggle', 'split'}) end)

hs.hotkey.bind(meh, "n", function () yabai({'-m', 'window', '--space', 'next'}) end)
hs.hotkey.bind(meh, "p", function () yabai({'-m', 'window', '--space', 'prev'}) end)

-- hs.hotkey.bind(meh, "e", function () yabai({'-m', 'window', '--resize', 'top:0:-100'}) end)
-- hs.hotkey.bind(meh, "s", function () yabai({'-m', 'window', '--resize', 'left:-100:0'}) end)
-- hs.hotkey.bind(meh, "d", function () yabai({'-m', 'window', '--resize', 'bottom:0:100'}) end)
-- hs.hotkey.bind(meh, "f", function () yabai({'-m', 'window', '--resize', 'right:100:0'}) end)

-- http://www.hammerspoon.org/docs/

hs.window.animationDuration = 0

-- debug print:
-- hs.console.printStyledtext(hs.inspect.inspect(obj))

---@diagnostic disable-next-line: unused-function
local function dump(o)
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

-- resize window to reasonable size - 60%, max 1025x900px
local function reasonableSize(window)
    if window == nil then
        window = hs.window.focusedWindow()
    end
    local screen = window:screen()
    local mode = screen:currentMode()
    local w = math.min(math.floor(mode.w * 0.6), 1025)
    local h = math.min(math.floor(mode.h * 0.6), 900)
    window:setSize(w, h)
    window:centerOnScreen()
end

-- grow window by 10%
local function grow()
    local window = hs.window.focusedWindow()
    local size = window:size()
    local w = math.floor(size.w * 1.1)
    local h = math.floor(size.h * 1.1)
    window:setSize(w, h)
end

-- shrink window by 10%
local function shrink()
    local window = hs.window.focusedWindow()
    local size = window:size()
    local w = math.floor(size.w * 0.9)
    local h = math.floor(size.h * 0.9)
    window:setSize(w, h)
end

local hyper = { "cmd", "alt", "ctrl", "shift" }
local meh = { "alt", "ctrl", "shift" }


-- MEH

-- hs.hotkey.bind(meh, "c", function() hs.window.focusedWindow():centerOnScreen() end)
-- hs.hotkey.bind(meh, "s", function() reasonableSize() end)
-- hs.hotkey.bind(meh, "u", function() grow() end)
-- hs.hotkey.bind(meh, "i", function() shrink() end)

local function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

hs.hotkey.bind(
    meh,
    "Space",
    -- pressedfn
    function()
        local layouts = hs.keycodes.layouts()
        local currentLayoutIndex = indexOf(layouts, hs.keycodes.currentLayout())
        local nextIndex = currentLayoutIndex + 1
        if nextIndex > #layouts then
            nextIndex = 1
        end
        local nextLayout = layouts[nextIndex]
        hs.keycodes.setLayout(nextLayout)
        hs.alert.showWithImage(nextLayout, hs.keycodes.currentLayoutIcon())
    end
)

-- DANISH --

local danish = hs.hotkey.modal.new(hyper, "d")
local timer = nil

local function exit()
    if timer ~= nil then
        timer:stop()
        print("timer stopped")
    else
        print("no timer")
    end
    danish:exit()
    print("danish exited")
end

-- timeout
function danish:entered()
    timer = hs.timer.doAfter(1, function()
        danish:exit()
    end)
end

-- lowercase
danish:bind('', 'a', function()
    exit()
    hs.eventtap.keyStrokes("å")
end)
danish:bind('', 'e', function()
    exit()
    hs.eventtap.keyStrokes("æ")
end)
danish:bind('', 'o', function()
    exit()
    hs.eventtap.keyStrokes("ø")
end)

-- uppercase
danish:bind('shift', 'a', function()
    exit()
    hs.eventtap.keyStrokes("Å")
end)
danish:bind('shift', 'e', function()
    exit()
    hs.eventtap.keyStrokes("Æ")
end)
danish:bind('shift', 'o', function()
    exit()
    hs.eventtap.keyStrokes("Ø")
end)

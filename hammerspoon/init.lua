-- http://www.hammerspoon.org/docs/

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

-- local hyper = { "cmd", "alt", "ctrl", "shift" }
local meh = { "alt", "ctrl", "shift" }


-- MEH

-- hs.hotkey.bind(meh, "m", mouseHighlight)
hs.hotkey.bind(meh, "c", function() hs.window.focusedWindow():centerOnScreen() end)
hs.hotkey.bind(meh, "s", function() reasonableSize() end)
hs.hotkey.bind(meh, "u", function() grow() end)
hs.hotkey.bind(meh, "i", function() shrink() end)

local windowBorderConfig = {
    color={red=1, green=0.3, blue=0.3, alpha=0.8},
    strokeWidth=8,
}

local globalBorderEnabled = true
local globalBorder = nil

function deleteWindowBorder()
    if globalBorder ~= nil then
        globalBorder:delete()
        globalBorder = nil
    end
end

function drawWindowBorder()
    if not globalBorderEnabled then
        return
    end

    local window = focused()
    if window ~= nil then
        local topLeft = window:topLeft()
        local size = window:size()
        deleteWindowBorder()
        globalBorder = hs.drawing.rectangle(
            hs.geometry.rect(topLeft["x"], topLeft["y"], size["w"], size["h"])
        )
        globalBorder:setStrokeColor(windowBorderConfig.color)
        globalBorder:setFill(false)
        globalBorder:setStrokeWidth(windowBorderConfig.strokeWidth)
        globalBorder:show()
    else
        deleteWindowBorder()
    end
end

function toggleWindowBorder()
    if globalBorderEnabled then
        globalBorderEnabled = false
        deleteWindowBorder()
    else
        globalBorderEnabled = true
        drawWindowBorder()
    end
end

drawWindowBorder()

Events: http://www.hammerspoon.org/docs/hs.window.filter.html
allWindows = hs.window.filter.new(nil)
allWindows:subscribe(hs.window.filter.windowCreated, drawWindowBorder)
allWindows:subscribe(hs.window.filter.windowDestroyed, drawWindowBorder)
allWindows:subscribe(hs.window.filter.windowFocused, drawWindowBorder)
allWindows:subscribe(hs.window.filter.windowMoved, drawWindowBorder)
allWindows:subscribe(hs.window.filter.windowUnfocused, drawWindowBorder)



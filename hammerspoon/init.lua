-- http://www.hammerspoon.org/docs/

hs.window.animationDuration = 0

-- debug print:
-- hs.console.printStyledtext(hs.inspect.inspect(obj))

---@diagnostic disable-next-line: unused-function
local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
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

local ctrl = { "ctrl" }

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
danish:bind("", "a", function()
	exit()
	hs.eventtap.keyStrokes("å")
end)
danish:bind("", "e", function()
	exit()
	hs.eventtap.keyStrokes("æ")
end)
danish:bind("", "o", function()
	exit()
	hs.eventtap.keyStrokes("ø")
end)

-- uppercase
danish:bind("shift", "a", function()
	exit()
	hs.eventtap.keyStrokes("Å")
end)
danish:bind("shift", "e", function()
	exit()
	hs.eventtap.keyStrokes("Æ")
end)
danish:bind("shift", "o", function()
	exit()
	hs.eventtap.keyStrokes("Ø")
end)

-- MOVE WINDOWS BETWEEN SPACES --
local function moveWindowToSpace(spaceNumber)
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert.show("No focused window")
		return
	end

	local windowSpaces = hs.spaces.windowSpaces(win)
	local originalSpace = windowSpaces and windowSpaces[1] or nil

	local labels = { "q", "w", "e", "r", "t", "y", "u", "i", "o", "p" }
	local spaceKey = labels[spaceNumber]

	local frame = win:frame()
	local titleBarPoint = {
		x = frame.x + frame.w / 2,
		y = frame.y + 3,
	}
	local originalPos = hs.mouse.absolutePosition()

	hs.mouse.absolutePosition(titleBarPoint)

	local steps = {
		{
			delay = 0.05,
			label = "Click title bar",
			fn = function()
				hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, titleBarPoint):post()
			end,
		},
		{
			delay = 0.15,
			label = "Navigate to new space",
			fn = function()
				hs.eventtap.event.newKeyEvent(hyper, spaceKey, true):post()
				hs.eventtap.event.newKeyEvent(hyper, spaceKey, false):post()
			end,
		},
		{
			delay = 0.4,
			label = "Release mouse",
			fn = function()
				hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, hs.mouse.absolutePosition()):post()
			end,
		},
		{
			delay = 0.01,
			label = "Move mouse back",
			fn = function()
				hs.mouse.absolutePosition(originalPos)
			end,
		},
		{
			delay = 0.01,
			label = "Return to original space",
			fn = function()
				if originalSpace then
					hs.spaces.gotoSpace(originalSpace)
				end
			end,
		},
	}

	local function runStep(i)
		if i > #steps then
			return
		end
		hs.timer.doAfter(steps[i].delay, function()
			print("Running step " .. i .. ": " .. steps[i].label)
			steps[i].fn()
			runStep(i + 1)
		end)
	end
	runStep(1)
end

hs.hotkey.bind(meh, "q", function()
	moveWindowToSpace(1)
end)
hs.hotkey.bind(meh, "w", function()
	moveWindowToSpace(2)
end)
hs.hotkey.bind(meh, "e", function()
	moveWindowToSpace(3)
end)
hs.hotkey.bind(meh, "r", function()
	moveWindowToSpace(4)
end)
hs.hotkey.bind(meh, "t", function()
	moveWindowToSpace(5)
end)
hs.hotkey.bind(meh, "y", function()
	moveWindowToSpace(6)
end)
hs.hotkey.bind(meh, "u", function()
	moveWindowToSpace(7)
end)

-- SPACE SWITCHING --
local function switchSpaces()
	local chooser = hs.chooser.new(function(choice)
		if not choice then
			return
		end
		print("Choice selected: " .. dump(choice))
		hs.spaces.gotoSpace(choice["space"])
	end)

	chooser:width(20) -- %

	local spacesForScreen = hs.spaces.spacesForScreen()
	if spacesForScreen == nil then
		hs.alert.show("No spaces found for current screen")
		return
	end

	-- print(dump(spacesForScreen))
	-- create choices as { { ["text"] = "Desktop 1", ["space"] = 1 }, ... }
	-- spacesForScreen is a list of space IDs, we need to get the name for each space ID
	local choices = {}
	for i, spaceID in ipairs(spacesForScreen) do
		-- TODO: use `hs.spaces.missionControlSpaceNames` to get actual names
		-- local spaceName = hs.spaces.spaceName(spaceID) or ("Space " .. i)
		local spaceName = "Desktop " .. i
		table.insert(choices, { ["text"] = spaceName, ["subText"] = spaceID, ["space"] = spaceID })
	end

	chooser:rows(#choices)
	chooser:choices(choices)
	chooser:show()
end

hs.hotkey.bind(hyper, "tab", function()
	switchSpaces()
end)

hs.hotkey.bind(hyper, "1", function()
	hs.eventtap.keyStroke(ctrl, "1")
end)
hs.hotkey.bind(hyper, "q", function()
	hs.eventtap.keyStroke(ctrl, "1")
end)

hs.hotkey.bind(hyper, "2", function()
	hs.eventtap.keyStroke(ctrl, "2")
end)
hs.hotkey.bind(hyper, "w", function()
	hs.eventtap.keyStroke(ctrl, "2")
end)

hs.hotkey.bind(hyper, "3", function()
	hs.eventtap.keyStroke(ctrl, "3")
end)
hs.hotkey.bind(hyper, "e", function()
	hs.eventtap.keyStroke(ctrl, "3")
end)

hs.hotkey.bind(hyper, "4", function()
	hs.eventtap.keyStroke(ctrl, "4")
end)
hs.hotkey.bind(hyper, "r", function()
	hs.eventtap.keyStroke(ctrl, "4")
end)

hs.hotkey.bind(hyper, "5", function()
	hs.eventtap.keyStroke(ctrl, "5")
end)
hs.hotkey.bind(hyper, "t", function()
	hs.eventtap.keyStroke(ctrl, "5")
end)

hs.hotkey.bind(hyper, "6", function()
	hs.eventtap.keyStroke(ctrl, "6")
end)
hs.hotkey.bind(hyper, "y", function()
	hs.eventtap.keyStroke(ctrl, "6")
end)

hs.hotkey.bind(hyper, "7", function()
	hs.eventtap.keyStroke(ctrl, "7")
end)
hs.hotkey.bind(hyper, "u", function()
	hs.eventtap.keyStroke(ctrl, "7")
end)

-- Left/Right navigation between spaces
hs.hotkey.bind(hyper, "h", nil, function()
	hs.eventtap.keyStroke({ "fn", "ctrl" }, "left")
end)
hs.hotkey.bind(hyper, "l", function()
	hs.eventtap.keyStroke({ "fn", "ctrl" }, "right")
end)

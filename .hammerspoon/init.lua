
local logger = hs.logger.new('init', 'debug')

function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  end

  return false
end


-- Press Cmd+Q twice to quit

local quitModal = hs.hotkey.modal.new('cmd','q')

function quitModal:entered()
    hs.alert.show("Press Cmd+Q again to quit", 1)
    hs.timer.doAfter(1, function() quitModal:exit() end)
end

local function doQuit()
    local app = hs.application.frontmostApplication()
    app:kill()
end

quitModal:bind('cmd', 'q', doQuit)

quitModal:bind('', 'escape', function() quitModal:exit() end)

-- END Press Cmd+Q


-- Copy timestamp

local datestampKeyModal = hs.hotkey.modal.new('', 'f9')

function datestampKeyModal:entered()
  local t = os.date("%Y-%m-%d")
  hs.pasteboard.setContents(t)
  hs.alert.show("Timestamp copied - " .. t)
  hs.timer.doAfter(1, function() datestampKeyModal:exit() end)
end


local datestampKeyModal = hs.hotkey.modal.new('shift', 'f9')

function datestampKeyModal:entered()
  local t = os.date("%Y-%m-%d %H:%M:%S")
  hs.pasteboard.setContents(t)
  hs.alert.show("Timestamp copied - " .. t)
  hs.timer.doAfter(1, function() datestampKeyModal:exit() end)
end

-- END Copy timestamp


-- The Perfect Window Size

local function setThePerfectWindowSize()
  win = hs.window.frontmostWindow()
  if win == nil then return end

  local f = win:frame()

  local screen = hs.screen'Lg'

  if screen == nil then
    hs.alert.show('Teeny Tiny Screen')
    return
  end

  if f.x == 621 and f.y == 259 then
    setThePerfectWindowSizeX2(f)
    return
  end

  hs.alert.show('The Perfect Window Size')
  
  f.x = 621
  f.y = 259
  f.w = 1324
  f.h = 942
  win:setFrame(f)
end

function setThePerfectWindowSizeX2(f)
  hs.alert.show('The Perfect Window, But Bigger!')

  f.x = 310
  f.y = 129
  f.w = 1986
  f.h = 1178
  win:setFrame(f)
end


-- hs.hotkey.bind({'cmd', 'ctrl', 'alt'}, 'w', setThePerfectWindowSize)


-- END The Perfect Window Size


-- Set Split Window

local function setSplitWindow(side)
  hs.alert.show('Set Split Window ' .. side)
  win = hs.window.frontmostWindow()
  if win == nil then return end

  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = 0
  f.y = 0
  f.h = max.h
  
  if side == 'left' then 
    f.w = max.w / 2
  elseif side == 'right' then
    f.x = max.x + (max.w / 2)
    f.w = max.w / 2
  else
    f.w = max.w
  end

  win:setFrame(f)
end

local function setSplitWindowLeft()
  setSplitWindow('left')
end

local function setSplitWindowRight()
  setSplitWindow('right')
end

local function setSplitWindowUp()
  setSplitWindow('up')
end

-- hs.hotkey.bind({'cmd', 'ctrl', 'alt'}, 'Left', setSplitWindowLeft)
-- hs.hotkey.bind({'cmd', 'ctrl', 'alt'}, 'Right', setSplitWindowRight)
-- hs.hotkey.bind({'cmd', 'ctrl', 'alt'}, 'Up', setSplitWindowUp)
-- hs.hotkey.bind({'cmd', 'ctrl', 'alt'}, 'Down', setThePerfectWindowSize)


-- END Set Split Window

local menubar = require('menubar')
menubar.init()

-- if file_exists("twm.lua") then
--   local twm = require('twm')
--   twm.init()
-- end

-- Screenshot curent window and save to desktop

-- local screenshotModal = hs.hotkey.modal.new('', 'f12')

-- function screenshotModal:entered()
--   local t = os.date("%Y-%m-%d %H-%M-%S")
--   hs.window.focusedWindow():snapshot():saveToFile(os.getenv("HOME") .. "/Desktop/" .. t .. ".png")
--   hs.alert.show("Saved")
--   hs.timer.doAfter(1, function() screenshotModal:exit() end)
-- end


hs.hotkey.bind({}, 'f12', function() 
  hs.eventtap.keyStroke({"cmd", "shift"}, '3')
end)

local menubar = {}

function menubar.init()
    initCaffeineBar()
end


-- Caffeine

caffeineBar = {}

function initCaffeineBar()
    caffeineBar = hs.menubar.new()
    caffeineBar:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get('displayIdle'))
    print('caffeineBar init displayIdle: ' .. tostring(hs.caffeinate.get('displayIdle')))
end

function setCaffeineDisplay(state)
    if state then
        caffeineBar:setTitle('😝')
    else
        caffeineBar:setTitle('🥱')
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
    print('caffeineBar caffeineClicked displayIdle: ' .. tostring(hs.caffeinate.get('displayIdle')))
end

-- END Caffeine


-- TWM Order Count


--  END TWM Order Count

return menubar

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.alert.show("Hello World!")
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

require("aerspace_keybinds")

local current_id = nil
local swipe_threshold = 0.08

hs.loadSpoon("Swipe")
spoon.Swipe:start(4, function(direction, distance, id)
    -- Identify the start of a new gesture
    if id ~= current_id then
        current_id = id
        swipe_threshold = 0.08 -- Reset the swipe threshold for the new gesture
    end

    if distance > swipe_threshold then
        -- Setting the threshold to infinity prevents further triggers within the same gesture
        swipe_threshold = math.huge

        if direction == "left" then
            os.execute("/usr/local/bin/aerospace focus left")
        end
        if direction == "right" then
            os.execute("/usr/local/bin/aerospace focus right")
        end
    end
end)

require("wifi_audio")

-- Pause music when screen locks
screenLockWatcher = hs.caffeinate.watcher.new(function(eventType)
    if eventType == hs.caffeinate.watcher.screensDidLock then
        os.execute("/usr/local/bin/nowplaying-cli pause")
    end
end)
screenLockWatcher:start()

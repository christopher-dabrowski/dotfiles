-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.alert.show("Hello World!")
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

aerospace = "/usr/local/bin/aerospace"
hs.hotkey.bind({"lalt"}, "l", function()
    os.execute(aerospace .. " focus right")
end)
hs.hotkey.bind({"lalt"}, "c", function()
    os.execute(aerospace .. " workspace C")
end)
hs.hotkey.bind({"lalt"}, "n", function()
    os.execute(aerospace .. " workspace N")
end)

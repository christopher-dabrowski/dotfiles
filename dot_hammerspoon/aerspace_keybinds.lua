hs.loadSpoon("LeftRightHotkey")
leftRightHotkey = spoon.LeftRightHotkey

aerospace = "/usr/local/bin/aerospace"
leftRightHotkey:bind({"l⌥"}, "l", function()
    os.execute(aerospace .. " focus right")
end)
leftRightHotkey:bind({"l⌥"}, "c", function()
    os.execute(aerospace .. " workspace C")
end)
leftRightHotkey:bind({"l⌥"}, "n", function()
    os.execute(aerospace .. " workspace N")
end)

leftRightHotkey:start()
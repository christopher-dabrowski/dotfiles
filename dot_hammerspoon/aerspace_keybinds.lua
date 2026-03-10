hs.loadSpoon("LeftRightHotkey")
leftRightHotkey = spoon.LeftRightHotkey

aerospace = "/usr/local/bin/aerospace"
leftRightHotkey:bind({"l⌥"}, "l", function()
    os.execute(aerospace .. " focus right")
end)

leftRightHotkey:bind({"l⌥"}, "c", function()
    os.execute(aerospace .. " workspace C")
end)
leftRightHotkey:bind({"l⌥", "lshift"}, "c", function()
    os.execute(aerospace .. " move-node-to-workspace C")
end)
leftRightHotkey:bind({"l⌥", "rshift"}, "c", function()
    os.execute(aerospace .. " move-node-to-workspace C")
end)
leftRightHotkey:bind({"l⌥"}, "n", function()
    os.execute(aerospace .. " workspace N")
end)
leftRightHotkey:bind({"l⌥", "lshift"}, "n", function()
    os.execute(aerospace .. " move-node-to-workspace N")
end)
leftRightHotkey:bind({"l⌥", "rshift"}, "n", function()
    os.execute(aerospace .. " move-node-to-workspace N")
end)

leftRightHotkey:start()
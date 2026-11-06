-- Sleep the Mac when the lid is closed, even with an external display attached (clamshell mode)

local function isLidClosed()
	local out = hs.execute("/usr/sbin/ioreg -r -k AppleClamshellState -d 4")
	return out:match('"AppleClamshellState"%s*=%s*Yes') ~= nil
end

-- Debounce: macOS reports several screen changes in a row
local pending
ClamshellSleepWatcher = hs.screen.watcher.new(function()
	if pending then
		pending:stop()
	end
	pending = hs.timer.doAfter(1, function()
		if isLidClosed() then
			hs.caffeinate.systemSleep()
		end
	end)
end)
ClamshellSleepWatcher:start()

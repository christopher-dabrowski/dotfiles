local targetNetworks = {
	"eduroam",
	"pw.edu.pl",
	"Green Caffe Nero",
	-- "2.4G-WorldGateway",
}

local targetOutputDeviceName = "Głośniki (MacBook Pro)"
local targetOutputDeviceUID = "0x600000e90c78"

local function listContains(list, value)
	for _, v in ipairs(list) do
		if v == value then
			return true
		end
	end
	return false
end

local previousVolume = nil
local previousMutedState = nil
local isMutedByAutomation = false

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--     print(hs.location.get()) -- Workaround to add option to enable location permissions for Hammerspoon
--   hs.alert.show("Wifi: " .. (hs.wifi.currentNetwork() or "None"))
-- end)

local function isTargetOutputDevice(device)
	if not device then
		return false
	end

	local deviceUID = device:uid()
	local deviceName = device:name()

	return deviceUID == targetOutputDeviceUID or deviceName == targetOutputDeviceName
end

local function restoreTargetOutputDevice()
	local targetDevice = hs.audiodevice.findOutputByUID(targetOutputDeviceUID)

	if not targetDevice then
		targetDevice = hs.audiodevice.findOutputByName(targetOutputDeviceName)
	end

	if not targetDevice then
		return
	end

	if previousMutedState ~= nil then
		targetDevice:setMuted(previousMutedState)
	end

	if previousVolume ~= nil then
		targetDevice:setVolume(previousVolume)
	end

	isMutedByAutomation = false
	previousVolume = nil
	previousMutedState = nil
end

local function handleStateChange()
	local currentNetwork = hs.wifi.currentNetwork()
	local defaultAudioDevice = hs.audiodevice.defaultOutputDevice()

	if not defaultAudioDevice then
		return
	end

	local shouldMute = currentNetwork
		and listContains(targetNetworks, currentNetwork)
		and isTargetOutputDevice(defaultAudioDevice)

	if shouldMute then
		if not isMutedByAutomation then
			previousVolume = defaultAudioDevice:volume()
			previousMutedState = defaultAudioDevice:muted()
			isMutedByAutomation = true
		end

		if defaultAudioDevice:muted() ~= true then
			defaultAudioDevice:setMuted(true)
		end
	elseif isMutedByAutomation then
		restoreTargetOutputDevice()
	end
end

WiFiAudioWatcher = hs.wifi.watcher.new(handleStateChange)
WiFiAudioWatcher:start()

local AudioDeviceWatcher = hs.audiodevice.watcher
AudioDeviceWatcher.setCallback(handleStateChange)
AudioDeviceWatcher.start()


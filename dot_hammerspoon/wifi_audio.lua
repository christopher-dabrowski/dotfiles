local targetNetworks = {
    "eduroam",
    "pw.edu.pl",
    "Green Caffe Nero"
}

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

local function handleWifiChange()
    local currentNetwork = hs.wifi.currentNetwork()
    local defaultAudioDevice = hs.audiodevice.defaultOutputDevice()

    if not defaultAudioDevice then return end

    if currentNetwork and listContains(targetNetworks, currentNetwork) then
        if not isMutedByAutomation then
            previousVolume = defaultAudioDevice:volume()
            previousMutedState = defaultAudioDevice:muted()

            defaultAudioDevice:setMuted(true)
            isMutedByAutomation = true
        end
    else
        if isMutedByAutomation then
            if previousMutedState ~= nil and defaultAudioDevice:muted() == true then
                defaultAudioDevice:setMuted(previousMutedState)
            end
            if previousVolume ~= nil and defaultAudioDevice:volume() == previousVolume then
                defaultAudioDevice:setVolume(previousVolume)
            end

            isMutedByAutomation = false
            previousVolume = nil
            previousMutedState = nil
        end
    end
end

WiFiAudioWatcher = hs.wifi.watcher.new(handleWifiChange)
WiFiAudioWatcher:start()
# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array ("en-PL", "pl-PL")
defaults write NSGlobalDomain AppleLocale -string "en_PL"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the time zone
sudo defaults write /Library/Preferences/com.apple.timezone.auto Active -bool YES
sudo systemsetup -setusingnetworktime on

# Using systemsetup might give Error:-99, can be ignored (commands still work)
# systemsetup manpage: https://ss64.com/osx/systemsetup.html

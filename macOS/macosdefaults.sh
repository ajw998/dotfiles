#!/bin/bash

set -x

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# systemsetup
sudo systemsetup -setusingnetworktime on
sudo nvram SystemAudioVolume=" "

sudo systemsetup -setrestartfreeze on

# Disable local Time Machine snaphosts
sudo tmutil disable
sudo tmutil disablelocal

# Disable crash report
defaults write com.apple.CrashReporter DialogType none

# Disable Bonjour multicast advertisements
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true

# Disable iCloud Saving
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Ask for password when waking the laptop
defaults read /Library/Preferences/com.apple.screensaver askForPassword

# No Delay between starting the screensaver and locking the computer
defaults -currentHost write /Library/Preferences/com.apple.screensaver askForPasswordDelay -bool false

# Do not respond to ICMP ping requests, in other words enable stealth mode
defaults write ~/Library/Preferences/com.apple.alf stealthenabled -bool true

# Disable Bluetooth
defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -bool false; killall -HUP blued

# Disable infrared receiver
defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

# Disable AirDrop
defaults_write_ignore_missing com.apple.NetworkBrowser DisableAirDrop -bool true

# Disable wake up on network access
systemsetup -setwakeonnetworkaccess off

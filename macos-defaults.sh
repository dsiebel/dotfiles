#!/usr/bin/env sh
# Source: https://github.com/SixArm/macos-defaults/blob/main/macos-defaults
# and adjusted using my own preferences.

# Demo script that shows how to script macOS `defaults` command
# to set many system preferences and application settings.
#
# This script is intended to work on macOS Monterey
# running on the Apple M1 chip.
#
# These are gathered from many different sources.
#
# Thanks:
#
#   * https://macos-defaults.com
#   * https://github.com/paulmillr/dotfiles
#   * https://github.com/mathiasbynens/dotfiles
#   * https://github.com/stianeikeland/dotfiles/edit/master/bin/sanemacdefaults.sh
#   * https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/

## Software Update

# TODO: Disabled because of org policies

# Enable the automatic update check
# defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Automatically download newly available updates in background
# defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
# defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
# defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

## NSGlobalDomain

# Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Always show scrollbars.
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Use “natural” (Lion-style) scrolling.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast KeyRepeat rate. We prefer 1 (15ms). The default minimum is 2 (30ms). May require reboot.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a fast initial key repeat. The default minimum is already 15 (225ms). May require reboot.
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "de"
defaults write NSGlobalDomain AppleLocale -string "de_DE@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

## NSGlobalDomain NS*

# Save to disk (not to iCloud) by default.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable typing automatic capitalization.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable typingautomatic period substition a.k.a. "smart stops".
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -int 0

# Disable typing automatic dash substitution e.g. "smart dashes".
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable typing automatic quote substitution a.k.a. "smart quotes".
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable typing automatic spelling correction a.k.a. "auto-correct".
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Expand save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Speed up window resize time.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

## Finder

# Show all files.
defaults write com.apple.finder AppleShowAllFiles YES

# Empty the trash securely by default (commented out because it's slow).
#defaults write com.apple.finder EmptyTrashSecurely -bool true

# Disable the warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Always open everything in Finder's list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Allow selection of text in quicklook windows.
defaults write com.apple.finder QLEnableTextSelection -bool true

# Enable quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Disable warning when the user does empty trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool false


## Dock

# Move Dock to the left side of the screen
defaults write com.apple.dock "orientation" -string "bottom" && killall Dock

# Make Dock icons of hidden applications translucent.
defaults write com.apple.dock showhidden -bool true

# Enable iTunes track notifications in the Dock.
defaults write com.apple.dock itunes-notifications -bool false

# Show indicator lights for open applications in the Dock.
defaults write com.apple.dock show-process-indicators -bool true

# Remove the auto-hiding Dock delay.
defaults write com.apple.Dock autohide-delay -float 0

# Automatically hide and show the Dock.
defaults write com.apple.dock autohide -bool true

# Disable expose animation.
defaults write com.apple.dock expose-animation-duration -float 0


## Screen Saver

# Require password immediately after sleep or screen saver begins.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

## Screen

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

## Safari

# TODO: Disabled, not using Safari

# # Include the Develop menu
# defaults write com.apple.Safari IncludeDevelopMenu -bool true

# # Include the Internal Debug menu.
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# # Enable WebKit Developer Extras preference key
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# # Enable WebKit Developer Extras
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# # Disable universal search because we prefer privacy
# defaults write com.apple.Safari UniversalSearchEnabled -bool false

# # Suppress search suggestions because we prefer privacy
# defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# # Don't open "safe" downloads i.e. don't open files automatically after downloading
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# # Disable snapshots i.e. don't use thumbnail cache for History and Top Sites
# defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# # Enable AutoFill
# defaults write com.apple.Safari AutoFillFromAddressBook -bool true
# defaults write com.apple.Safari AutoFillPasswords -bool true
# defaults write com.apple.Safari AutoFillCreditCardData -bool true
# defaults write com.apple.Safari AutoFillMiscellaneousForms -bool true


## Network Browser

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1


## Terminal

# Only use UTF-8 in Terminal.app.
defaults write com.apple.terminal StringEncodings -array 4


## Desktop Services

# Avoid creating .DS_Store files on network volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true


## Bluetooth

# Set Bluetooth headset higher bitrate.
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40


## Press And Hold

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false


## Quick Look

# Settings for qlcolorcode quicklook plugin.
# https://github.com/n8gray/QLColorCode
# https://github.com/sindresorhus/quick-look-plugins
# defaults write org.n8gray.QLColorCode hlTheme pablo
# defaults write org.n8gray.QLColorCode font Monaco

## Trackpad

# disable tap to click (Trackpad), also for login menu.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
sudo defaults write com.apple.AppleMultitouchTrackpad Clicking 0


## Flags

# Show the ~/Library folder.
chflags nohidden ~/Library


## Login window

# Show host info e.g. IP address, hostname, OS version, etc. when you click the clock
# sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Berlin" > /dev/null

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

## Energy saving

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically on power loss
sudo pmset -a autorestart 1

# Restart automatically if the computer freezes
#sudo systemsetup -setrestartfreeze on

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 5

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage

## Finally

# Kill affected applications.
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done

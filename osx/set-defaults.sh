#
# Set up OS X stuffs
#

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a fast-ish key repeat.
defaults write NSGlobalDomain KeyRepeat -int 2

# Display hostname & IP address (works?)
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
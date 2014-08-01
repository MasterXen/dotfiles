#!/bin/sh
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
# browser.gesture.swipe.left  Browser:BackOrBackDuplicate
# browser.gesture.swipe.right Browser:ForwardOrForwardDuplicate

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

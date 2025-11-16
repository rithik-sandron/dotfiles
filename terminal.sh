#!/bin/zsh

# set directory
PROFILE_PATH="$(cd "$(dirname "$0")" && pwd)/zsh.terminal"

if [ ! -f "$PROFILE_PATH" ]; then
  echo "Error: Terminal profile file not found at $PROFILE_PATH"
  exit 1
fi

open "$PROFILE_PATH"
sleep 2

defaults write com.apple.Terminal "Default Window Settings" -string "$(basename "$PROFILE_PATH" .terminal)"
defaults write com.apple.Terminal "Startup Window Settings" -string "$(basename "$PROFILE_PATH" .terminal)"

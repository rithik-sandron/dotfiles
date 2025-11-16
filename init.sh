#! /bin/zsh

# get current username of the mac
username=$(id -un)

chmod u+x *.sh
./github.sh
./packages.sh
./vscode.sh
./terminal.sh

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "✅ "$username"'s mac setup completed!"

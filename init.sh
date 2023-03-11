#! /usr/bin/zsh

echo -n 'Please provide a name [GitHub name prefered]: 👽'
read name

echo -n 'Please provide your mail ID [GitHub mail prefered]: 📩'
read mail

echo "
[user]
	name = Rithik
	email = "$mail"
"  >>  .gitconfig

# system linking dotfiles in the base directory
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zprofile ~/.zprofile
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.hushlogin ~/.hushlogin

# github ssh setup
ssh-keygen -t ed25519 -C "$mail"
# accept default location
# provide a passphrase
if test ! -f "~/.ssh/config"; then
	touch ~/.ssh/config
fi

cat << EOF > ~/.ssh/config
Host *.github.com
  AddKeysToAgent yes
  IgnoreUnknown UseKeychain
  IdentityFile ~/.ssh/id_ed25519
EOF

# adding SSH private key to the ssh-agent 
ssh-add ~/.ssh/id_ed25519

# Add the SSH key to your account on GitHub. For more information, see "Adding a new SSH key to your GitHub account."

# adding your SSH key to the ssh-agent
eval "$(ssh-agent -s)"

# check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# added below cmd to the dotfiles .zprofile
	#echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> /Users/$USER/.zprofile
	eval $(/opt/homebrew/bin/brew shellenv)
fi

echo "🚫 disabling homebrew analytics..."
brew analytics off

# update homebrew recipes
echo "updating brew..."
brew update

# packages to be installed
PACKAGES=(
	git
	node
	java11
)

for package in "${PACKAGES[@]}"
do
	echo "🔸 installing ${package}..."
	brew install ${package}
done

echo "cleaning up homebrew..."
brew cleanup

# casks to be installed
CASKS=(
	intellij-idea-ce
	visual-studio-code
	steam
	firefox
	github
)

for cask in "${CASKS[@]}"
do
	echo "🔹 installing ${cask}..."
	brew install --cask ${cask}
done

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "🕘 installing xcode, might take some time..."
xcode-select --install

echo "✅ "$mail"'s mac setup completed!"

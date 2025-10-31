#! /bin/bash

# get current username of the mac
username=$(id -un)

echo -n 'Please provide a name [GitHub name prefered]: 👽'
read name

echo -n 'Do you want to generate key for GitHub [y/n]: '
read gflag

if [ "y" = "$gflag" ] || [ "Y" = "$gflag" ]; then 

echo -n 'Please provide your mail ID [GitHub mail prefered]: 📩'
read mail

echo "
[user]
	name = "$name"
	email = "$mail"
"  >>  ~/dotfiles/.gitconfig

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

fi

echo "🕘 installing xcode, might take some time..."
xcode-select --install

script_dir="$(cd "$(dirname "$0")" && pwd)"
echo "$script_dir"

# system linking dotfiles in the base directory
cp $script_dir/.aliases ~/
cp $script_dir/.gitconfig ~/
cp $script_dir/.hushlogin ~/
cp $script_dir/.zshrc ~/
cp $script_dir/.zprofile ~/

# check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # added below cmd to the dotfiles .zprofile
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/"$username"/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "🚫 disabling homebrew analytics..."
brew analytics off

# update homebrew recipes
echo "updating brew..."
brew update

# packages to be installed
PACKAGES=(
	git
	shfmt
   	sqlite
)

for package in "${PACKAGES[@]}"
do
	echo "🔸 installing ${package}..."
	brew install ${package}
done

# casks to be installed
CASKS=(
	visual-studio-code
	steam
	spotify
)

for cask in "${CASKS[@]}"
do
	echo "🔹 installing ${cask}..."
	brew install --cask ${cask}
done

# Add Visual Studio Code (code)
echo '\nexport PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> ~/.zshrc

# for openjdk
echo '\nexport PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

echo "cleaning up homebrew..."
brew cleanup

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "✅ "$name"'s mac setup completed!"

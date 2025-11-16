#! /bin/zsh

echo "🕘 installing xcode, might take some time..."
xcode-select --install

script_dir="$(cd "$(dirname "$0")" && pwd)"

# system linking dotfiles in the base directory
cp $script_dir/.aliases ~/
cp $script_dir/.gitconfig ~/
cp $script_dir/.hushlogin ~/
cp $script_dir/.zshrc ~/
cp $script_dir/.zshenv ~/
cp $script_dir/.zprofile ~/

# check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
	echo "installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# added below cmd to the dotfiles .zprofile
	(
		echo
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
	) >>~/.zprofile
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
	gh
	shfmt
	sqlite
)

for package in "${PACKAGES[@]}"; do
	echo "🔸 installing ${package}..."
	brew install ${package}
done

# casks to be installed
CASKS=(
	visual-studio-code
	steam
	spotify
)

for cask in "${CASKS[@]}"; do
	echo "🔹 installing ${cask}..."
	brew install --cask ${cask}
done

cat <<EOF >>~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

echo "cleaning up homebrew..."
brew cleanup

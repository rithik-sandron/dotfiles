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

echo "installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# added below cmd to the dotfiles .zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

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

    # devops
    kubectl
    helm
    uv
    argocd
    redis
    podman
    kind
    opentofu

    # ai
    anomalyco/tap/opencode
)

echo 'eval "$(uv generate-shell-completion zsh)"' >>"$zshrc"
echo 'eval "$(uvx --generate-shell-completion zsh)"' >>"$zshrc"
uv tool install mlx-lm
uv tool update-shell

for package in "${PACKAGES[@]}"; do
    echo "🔸 installing ${package}..."
    brew install ${package}
done

# casks to be installed
CASKS=(
    google-cloud-sdk
    zed
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

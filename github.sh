#! /bin/zsh

echo -n 'Please provide a GitHub name: 👽'
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
" >>~/dotfiles/.gitconfig

	# github ssh setup
	ssh-keygen -t ed25519 -C "$mail"
	# accept default location
	# provide a passphrase
	if test ! -f "~/.ssh/config"; then
		touch ~/.ssh/config
	fi

	cat <<EOF >~/.ssh/config
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

## To make this work
1. Copy the files to your `~` directory.
2. Run `./init.sh `

#### This will 
- Add config for the terminal(zsh), github, vscode etc.
- Generate ssh key for github.
- Install necessary casks and packages you need for your Mac.
- Adds useful aliases for commands.

## Things to do after `init.sh`
1. Add the SSH key to your account on GitHub. Run the below command to open your safari browser or open any browser of your choice.
```
open -a Safari https://github.com/settings/keys
``` 

2. Run the command to copy your ssh key. And add the copied ssh key to your GitHub account.
```
gh ssh-key add ~/.ssh/id_ed25519.pub
``` 

3. check if all system links are in place. [under `~`] `la` 

4. change your name and email in `.gitconfig` file
```
nano ~/.dotfiles/.gitconfig
```

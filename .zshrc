source ~/.dotfiles/.aliases

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
export PROMPT='%U%B%F{green}%*%f%b%u %U%B%F{yellow}%~%f%b%u %B%F{cyan}$%f%b ' 

export RPROMPT='%S%F{cyan} ${vcs_info_msg_0_}%f%s'

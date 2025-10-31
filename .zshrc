source ~/.aliases

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST

export PROMPT='%F{154}%D{%A} %t%f %F{175}%c%f %F{203}-${vcs_info_msg_0_}%f 🔶 '
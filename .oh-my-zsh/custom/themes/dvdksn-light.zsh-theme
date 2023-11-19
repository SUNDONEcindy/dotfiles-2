# af-magic-light.zsh-theme
#
# Author: Andy Fleming
# URL: http://andyfleming.com/

# primary prompt: dashed separator, directory and vcs info
PS1="$FG[056]%~\$(git_prompt_info) $FG[127]%(!.#.$)%{$reset_color%} "
PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: vi mode
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/[N]}/(main|viins)/[I]}"
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[056]}(${FG[028]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[202]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[056]})%{$reset_color%}"

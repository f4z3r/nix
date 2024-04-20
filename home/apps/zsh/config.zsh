bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Add stuff for auto-complete
zstyle ':autocomplete:*' delay 0.1  # seconds (float)
zmodload zsh/complist
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

# Add custom binds
bindkey "^y" vi-cmd-mode
bindkey "^n" vi-down-line-or-history
bindkey "^p" vi-up-line-or-history
bindkey -M menuselect "^n" vi-down-line-or-history
bindkey -M menuselect "^p" vi-up-line-or-history
bindkey -a "^n" vi-down-line-or-history
bindkey -a "^p" vi-up-line-or-history
bindkey -a "^h" vi-beginning-of-line
bindkey -a "^l" vi-end-of-line
bindkey "^f" forward-char

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
    printf '%s' "${terminfo[smkx]}"
  }
  function zle-line-finish () {
    printf '%s' "${terminfo[rmkx]}"
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

autoload -U add-zsh-hook

function _interactive_sofa() {
  emulate -L zsh
  zle -I

  echoti rmkx
  output=$(sofa -i)
  echoti smkx

  if [[ -n $output ]]; then
    LBUFFER=$output
  fi

  zle reset-prompt
}

zle -N _interactive_sofa_widget _interactive_sofa
bindkey '^o' _interactive_sofa_widget

# do not add stuff to history containing "password"
function zshaddhistory() {
  emulate -L zsh
  if [[ "${1:l}" = *"pass"* ]]; then
    return 1
  elif [[ "${1:l}" = *"secret"* ]]; then
    return 1
  elif [[ "${1:l}" = *"token"* ]]; then
    return 1
  elif [[ "${1:l}" = *"api-key"* ]]; then
    return 1
  elif [[ "${1:l}" = *"api_key"* ]]; then
    return 1
  fi
}

umask 027

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
path=("$HOME/.local/bin/" "$HOME/.luarocks/bin/" $path)
export PATH

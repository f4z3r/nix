bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Add custom binds
bindkey "^y" vi-cmd-mode
bindkey "^n" vi-down-line-or-history
bindkey "^p" vi-up-line-or-history
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

function _hoard_list() {
  emulate -L zsh
  zle -I

  echoti rmkx
  output=$(hoard --autocomplete list 3>&1 1>&2 2>&3)
  echoti smkx
  
  if [[ -n $output ]]; then
    LBUFFER=$output
  fi

  zle reset-prompt
}

zle -N _hoard_list_widget _hoard_list

bindkey '^o' _hoard_list_widget

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

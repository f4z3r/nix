set -x GREP_COLORS "mt=01;33:ms=01;33:mc=01;33:sl=:cx=:fn=35:ln=32:bn=32:se=36"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANROFFOPT "-c"

# erase greeting
set fish_greeting

# add local binaries to path
fish_add_path -p "$HOME/.local/bin/" "$HOME/.luarocks/bin/"

# use gruvbox theme
theme_gruvbox $NIX_THEME medium

# key bindings
fish_vi_key_bindings insert
bind -M insert \cy 'set fish_bind_mode default; commandline -f repaint'
bind -M insert \cf accept-autosuggestion
bind -M insert \cp up-or-search
bind \cp up-or-search
bind -M insert \cn down-or-search
bind \cn down-or-search
bind -M insert \ch beginning-of-line
bind \ch beginning-of-line
bind -M insert \cl end-of-line
bind \cl end-of-line

function __interactive_sofa
    set output (sofa -i)
    commandline -j $output
end

bind \co __interactive_sofa
bind -M insert \co __interactive_sofa

function edit_cmd --description 'Edit cmdline in editor'
    set -l f (mktemp --tmpdir=.)
    set -l p (commandline -C)
    commandline -b >$f
    nvim -c set\ ft=fish $f
    commandline -r (more $f)
    commandline -C $p
    rm $f
end

bind -M insert \ce edit_cmd
bind \ce edit_cmd

# fifc settings
function __interactive_broot
    set output (broot)
    commandline -ij $output
end

bind \ct __interactive_broot
bind -M insert \ct __interactive_broot

# useful functions
function backup --argument filename
  cp -r $filename $filename.bak
end


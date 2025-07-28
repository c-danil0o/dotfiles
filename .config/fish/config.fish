function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

alias pamcan=pacman

alias ls="exa --icons" # ls
alias ll='exa -lbF --git' # list, size, type, git
alias llm='exa -lbGd --git --sort=modified' # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1' # one column, just names
alias lt='exa --tree --level=2' # tree
alias y='yazi'

alias powersave='sudo ryzenadj --stapm-limit=6000 --fast-limit=8000 --slow-limit=6000 --tctl-temp=90'
alias performance='sudo ryzenadj --stapm-limit=60000 --fast-limit=65000 --slow-limit=60000 --tctl-temp=90'
alias balance='sudo ryzenadj --stapm-limit=14000 --fast-limit=17000 --slow-limit=15000 --tctl-temp=90'

alias monitor-r-off='hyprctl dispatch dpms off DP-8'
alias monitor-r-on='hyprctl dispatch dpms off DP-8'

alias pff='poweroff'

# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end
set -Ux EDITOR nvim
set -Ux VISUAL nvim
zoxide init fish | source
set PATH $PATH ~/.cargo/bin
set -x PATH $PATH (go env GOPATH)/bin

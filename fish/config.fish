set -Ux EDITOR vim
set -Ux FZF_DEFAULT_COMMAND 'fd --type f'

# a much better color than the old grey thing (at least for my colors)
set fish_color_autosuggestion brblack

set -gx PATH ~/.local/bin/ ~/go/bin ~/.gem/ruby/2.5.0/bin $PATH

alias curl="curl -L"
alias ncurl="curl --proxy 'proxy.det.nsw.edu.au:8080' --proxy-ntlm --proxy-user 'mathieu.paturel'"
alias ls="ls -NF --color=auto --group-directories-first"
alias gittips='gittips ~/.cache/git-tips.json'

abbr -a password='date +%s | sha256sum | base64 | head -c 32 | xclip -selection clipboard'

alias fullbat="upower -i /org/freedesktop/UPower/devices/battery_BAT1"
alias bat="fullbat | command grep 'percentage\|state\|time to'"
alias notepad='vim -u ~/.vimrc.min'
alias l='history | head -n 1'
alias types='cat ~/.local/angular-commit-types'

abbr -a ip='ip -c'
abbr -a path='echo $PATH | tr " " "\n" '

# git abbreviations
abbr -a gs='git status --short'
abbr -a gc 'git commit'
abbr -a gca 'git commit -a'
abbr -a gl 'git log --oneline --decorate --graph --all'

abbr -a todo 'vim ~/todo.md'
abbr -a h heroku
abbr -a g grep

abbr -a grip 'grip --quiet . 0.0.0.0:9997'

abbr -a e 'vim ~/.config/fish/config.fish'
abbr -a s 'source ~/.config/fish/config.fish'

# if status is-interactive; and not string match '*tmux*' $TERM > /dev/null
    # tmux
    # echo "Probably want to exit now"
# end

function export_last_command --on-event fish_preexec
    set -g last_command $argv
end

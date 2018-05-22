# vim: set ft=fish foldmethod=marker:

set -x CDPATH . .. ~

# Abbreviations {{{
abbr -a gs="git status"
abbr -a gd="git diff -w"
abbr -a go="git checkout"
abbr -a gc="git commit"
abbr -a gr="git rebase"
abbr -a gz="git stash"
abbr -a gp="git push"
abbr -a gf="git pull"
abbr -a gv="git svnup"
abbr -a gl="git log"
abbr -a g1="git log --oneline"
abbr -a gu="git add -u"
abbr -a gg="git --no-pager grep -n --break"
# }}}

# Aliases {{{
alias g="git --no-pager grep -n --break"
alias rl="source ~/.config/fish/config.fish"
alias mux="tmuxinator"
alias tmux="~/local/bin/tmux -2"
alias e="emacsclient -n"
# }}}

# Functions {{{
# }}}

# Miscellaneous {{{
set -x GTAGSFORCECPP 1
set -x EDITOR emacsclient

# Load BATS configuration (it it exists)
if test -f ~/.config/fish/bats.fish
    source ~/.config/fish/bats.fish
end
# }}}


#TODO: add alias/function for adding todos! to .files mostly (eg adding todo to map emacs key)

#vars (needs to move)
export DF=$DOTFILES
export DFA=$DF/alias
export DFZ=$DF/zsh
export DFE=$DF/emacs
export DFV=$DF/vim
export DFK=$DF/kbd

#===============================
# YO DAWG! I HEARD YOU LIKE ALIASES!
#===============================
# THESE ARE THE MOST IMPORTANT ALIASES!!!
#   ESPECIALLY THE FIRST ONE: AGR=ALIAS | GREP
alias agr="alias | grep "
alias hgr="history | grep "
alias pgr="ps aux | grep "

#===============================
# EMACS
#===============================
alias demacs="emacs --daemon"
alias wemacs="emacsclient -c"
alias temacs="emacsclient -t"
#alias remacs="" #start emacs in rinari mode

#===============================
# EDIT DOTFILES
#===============================
alias cdf="cd $DF"
alias emem="cd $DFE && emacs init.el"
alias emkem="cd $DFK && emacs bindkeys.emacs.mac"
alias emrem="cd $DFE && emacs support/rails.el"

alias emalias="cd $DFA && emacs alias.sh"
alias emfunc="cd $DFA && emacs func.sh"
alias emzsh="cd $DFZ && emacs zshrc"
alias emkey="cd $DFK && emacs KeyRemap4MacBook/private.xml"

#===============================
# EDIT PROFILES
#===============================
#edit profiles
alias vbash='vim ~/.bashrc'
alias vbashp='vim ~/.bash_profile'
alias vzsh='vim ~/.zsh/.zshrc'

#===============================
# REFRESH PROFILES
#===============================
#refresh profiles
alias sbash='source ~/.bashrc'
alias sbashp='source ~/.bash_profile'
alias szsh='source ~/.zsh/.zshrc'

#===============================
# LS
#===============================
alias la='ls -alhG'
alias ll='ls -lhG'
alias lsym='ll | grep -e -\>'
alias lasym='la | grep -e -\>'
#alias lah=only hidden
#alias lahl=only hidden details

#===============================
# LN
#===============================
alias lns='ln -s'

#===============================
# GIT
#===============================
alias gpo='git push origin '
#alias gpom='git push origin master' # NVR EVR commit 2 master! Das Dangerous!
alias gpushnew='git push -u origin ' ##
#alias force-push='git push --force ' # validate args with function on this one

# pull
alias gpum='git pull origin master'

# fetch
alias gf="git fetch"
alias gfo="git fetch origin"

# merge

# rebase
alias germ="git rebase master"

# status
alias gsas='git status'
alias gsta='git status'

# add/rm
alias gad='git add'
alias grm='git rm'

# commit
alias gcom='git commit -m'

# checkout/branch
alias gch='git checkout'
alias gchb='git checkout -b'
alias gbl='git branch'

# def
alias gdf='git diff'
alias gdif='git diff'

#===============================
# HISTORY
#===============================
# alias clear history
# alias save history
# alias open history in emacs/vim
# function gist n lines of history

# why 9?
#   bc 9 is the largest single digit number
alias h9="history | tail -n 9 "
alias h9g="history | tail -n 9 | grep "

# why 21?
#   bc it's 2 and 1 are adjacent
#   and it's easier to hit adjacent keys
alias h21="history | tail -n 21 "
alias h21g="history | tail -n 21 | grep "

# why 3?
#   bc 10^3 = 100.  that's why
alias h3="history | tail -n 100 "
alias h3g="history | tail -n 100 | grep "

#===============================
# DIG - DNS INFO GROPER
#===============================
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

#===============================
# CHEAT SHEETS (opens urls)
#===============================
alias cheatminitest="open http://cheat.errtheblog.com/s/minitest"

#===============================
# TOLEARN.md
#===============================
# trying to keep uptodate files of
#   new things i've learned,
#   but haven't committed to
#   muscle memory yet
# trying to avoid hitting google
#   for everything.  time killer!

alias lemacs='less ~/.files/emacs/TOLEARN.md'
alias learnemacs='less ~/.files/emacs/TOLEARN.md'

#misc
alias rf='rm -rf'
alias df='df -h' #show remaining space in megs

#==========================
# CHANGE SHELLS
#==========================
alias set-zsh-default='chsh -s /bin/zsh'
alias set-bash-default='chsh -s /bin/bash'
#alias set-fish-default='chsh -s /bin/fish'

#==========================
# GEMS
#==========================
alias gemd="gem list -d "
alias gemi="gem install "

#==========================
# RVM
#==========================
alias rvl="rvm list"
alias rvlg="rvm gemset list"
alias rvu="rvm use "
alias rvug="rvm gemset use "

#==========================
# RAILS
#==========================

#__________________________
# starting
alias brs="bundle exec rails server"
alias brc="bundle exec rails console"

#__________________________
# testing
alias bgs="bundle exec guard start"
alias rkt="bundle exec rake test"
alias rkprep="bundle exec rake db:test:prepare"
alias rkmig="bundle exec rake db:migrate"
alias rkdbc="bundle exec rake db:create"
alias rkdbca="bundle exec rake db:create:all"

#__________________________
# zeus
alias zs="zeus start"
alias zt="zeus test"

#==========================
# APPEND NEW ALIASES QUICKLY!
#==========================
# APALI - a function to extract rainbows from unicorns
#           using trade-secret cold-water extraction method

# quickly add new aliases after a pattern
#   then sort out aliases later
APALI_REGEX=$(printf '%q' '#__APALI__#')
#APALI_REGEX="__APALI__"

alias apali="insert-alias $DFA/alias.sh $APALI_REGEX "
alias apalim="insert-alias $DFA/alias.mac.sh $APALI_REGEX "
alias apaliu="insert-alias $DFA/alias.ubu.sh $APALI_REGEX "

#__________________________
# new aliases will magically appear here
#   to be sorted out later

# TODO: fix apali for multiple args =/ have to use quotes

#__APALI__#
alias vagbbt=vagrant basebox templates
alias vagbbb=vagrant basebox build
alias vagbbl=vagrant basebox list
alias vagbrp=vagrant basebox repackage
alias vagba=vagrant box add
alias vagbl=vagrant box list
alias tarcz=tar -czxf
alias tarz=tar -zxf

#TODO: add alias/function for adding todos! to .files mostly (eg adding todo to map emacs key)

#vars (needs to move)
export DF=$DOTFILES
export DFA=$DF/alias
export DFZ=$DF/zsh
export DFE=$DF/emacs
export DFV=$DF/vim
export DFK=$DF/kbd

#glock() { kill -$("$1") $2 }

#===============================
# YO DAWG! I HEARD YOU LIKE ALIASES!
#===============================
# THESE ARE THE MOST IMPORTANT ALIASES!!!
#   * ESPECIALLY THE FIRST ONE: AGR=ALIAS | GREP
#   * changed to use functions
agr() { alias | grep -e "$*"; }
hgr() { history | grep -e "$*"; }
pgr() { ps aux | grep -e "$*"; }
lgr() { ls -al | grep -e "$*"; }

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
# CD
#===============================
alias c-v='cd ~/ops/vagrant'
alias c-o='cd ~/ops'
alias c-h='cd ~/dev/homebrew'
alias c-br='cd ~/dev/homebrew'
alias c-da='cd /Volumes/data'
alias c-nw='cd ~/dev/neighbornet/sfw'
alias c-n='cd ~/dev/neighbornet'
alias c-d='cd ~/dev'
alias c-df='cd /Users/dc/.files'
alias c-bash='cd ~/dev/bash'
alias c-ubu='cd ~/dev/ubuntu'
alias c-sec='cd ~/dev/sec'
alias c-no='cd ~/dev/node'
alias c-mru='cd ~/dev/mruby'
alias c-dro='cd ~/dev/droid'
alias c-boom='cd ~/dev/boomalang'
alias c-r='cd ~/dev/r'
alias c-ra='cd ~/dev/rails'
alias c-g='cd ~/dev/gems'
alias c-rb='cd ~/dev/ruby'
alias c-e='cd ~/dev/emacs'
alias c-bf='cd ~/dev/emacs/buffless'

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
#push
alias gpo='git push origin '
#alias gpom='git push origin master' # NVR EVR commit 2 master! Das Dangerous!
alias gpushnew='git push -u origin ' ##
#alias force-push='git push --force ' # validate args with function on this one

# pull
alias glm='git pull origin master'

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
alias gcd='git checkout develop'
alias gpod='git pull origin develop'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gbl='git branch'
alias gbD='git branch -D '
alias gbd='git branch -d '
gchr() { git checkout -b "origin/$1"; }

# diff
alias gdf='git diff'
alias gdif='git diff'

# difftools
alias gkmdf='git mergetool -y -t Kaleidoscope'
alias gkdf='git difftool -y -t Kaleidoscope'

# gls

# stash
alias gsh='git stash '
alias gshp='git stash pop '
alias gresk='git rebase --skip'
alias grecon='git rebase --continue'

# gitar
alias gitara='gitar $ra'

#gitlist

#===============================
# HUB
#===============================
# http://defunkt.io/hub/
# https://github.com/defunkt/hub#commands
# USE HUB!!! no, really lol `brew install hub`
#   for pull requests, forks and spoons

#===============================
# MISC
#===============================
alias rgs="xargs -I -=-="

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
alias cheatcapy="open http://makandracards.com/makandra/1422-capybara-the-missing-api"

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
# getting gem info
alias gemd="gem list -d "
alias gemi="gem install "

# building gems
alias gemp='gem push'
alias gemb='gem build'

#==========================
# RVM
#==========================
alias rvl="rvm list"
alias rvlg="rvm gemset list"
alias rvu="rvm use "
alias rvug="rvm gemset use "
alias rvm-update="rvm get stable"

#==========================
# GUARD
#==========================

#==========================
# FOREMAN
#==========================
# bundle exec necessary?
alias 4mc="bundle exec foreman check -f Procfile"
alias 4ms="bundle exec foreman start -f Procfile"
alias 4md="bundle exec foreman start -f Procfile.dev"
alias 4mdmem="bundle exec foreman start -f Procfile.mem"
#alias forsbg='fors &> /dev/null'
#alias fors='bundle exec foreman start -f Procfile.dev'

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
# https://makandracards.com/makandra/1422-capybara-the-missing-api
alias zst="zeus start"
alias zs="zeus server"
alias zg="zeus generate"
alias zr="zeus rake"
alias zc='zeus console'
alias zt="zeus test"

#==========================
# VAGRANT
#==========================
alias vagbbt="vagrant basebox templates"
alias vagbbb="vagrant basebox build"
alias vagbbl="vagrant basebox list"
alias vagbrp="vagrant box repackage"
alias vagba="vagrant box add"
alias vagbl="vagrant box list"

#==========================
# HEROKU
#==========================
alias herlo='heroku login'
alias heropush='git push heroku master'
alias herkad='heroku keys:add '


#==========================
# APPEND NEW ALIASES QUICKLY
#==========================
# APALI - a function to extract rainbows from unicorns
#           using trade-secret cold-water extraction method

# quickly add new aliases after a pattern
#   then sort out aliases later
APALI_REGEX=$(printf '%q' '#__APALI__#')
#APALI_REGEX="__APALI__"

# NOTE: FOR NOW THE QUOTING FOR THESE IS A LITTLE BROKE
#   YOU MUST SURROUND THE SECOND ARG with "'cmd'"
# EG:  apali foo "'bar --opts opt1 arg1 arg2 '"
#  TRIPLE QUOTES -- IT'S A HAT TRICK LOLOLOL SMH

alias apali="insert-alias $DFA/alias.sh $APALI_REGEX "
alias apalim="insert-alias $DFA/alias.mac.sh $APALI_REGEX "
alias apaliu="insert-alias $DFA/alias.ubu.sh $APALI_REGEX "

# also you will have wierd bugs if you are trying to insert
#   something that your shell session already recognizes
#   as an alias!

#__________________________
# new aliases will magically appear here
#   to be sorted out later

# TODO: fix apali for multiple args =/ have to use quotes
# TODO: apali needs to pass quotes.
# TODO: just change it to use sed. FML lol

#__APALI__#
alias ping8='ping 8.8.8.8'
alias c-lj='cd /Users/dc/dev/clj'
alias c-ha='cd /Users/dc/dev/hack4co/hackForCO'
alias tree='tree -C'
alias glnr='git pull --no-rebase origin'
alias c-co='cd /Users/dc/dev/hack4co/hackCO'
alias reads='read -s'
alias emfi='cd /Users/dc/.files && emacs README'
alias gre='grep -e'
alias cr='cp -R'
alias rw='rspec-web'
alias brewd='brew list -d '
alias tarcz="tar -czxf"
alias tarz="tar -zxf"
alias ncns="cd ~/dev/rails/incense"

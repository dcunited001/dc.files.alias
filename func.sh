#!/bin/bash
# shell functions for all platforms


#===============================
# Hub Auth
#===============================
alias hub="hub-auto-auth; hub"
hub-auto-auth() {
  if [ -n $GITHUB_USER ]; then read -s GITHUB_USER; else echo "USERNAME: $GITHUB_USER"; fi
  if [ -n $GITHUB_PASSWORD ]; then read -s GITHUB_PASSWORD; else echo "PASSWORD: ..."; fi; }

#===============================
# Git Branch Vars
#===============================

# examples of Vars i use to speed up development on multiple branches

# These vars, combined with gitar, gitlist, gull, gync, and gush
#   ARE AWESOME!

#===============================
### current branches
# g=dc/feature/cool-feature-bro
# gg=dc/feature/user-is-rad
# ggg=dc/feature/user-friends-friends-friends
 
# gh=dc/hotfix/admin-user-no-friends
 
# gt=dc/test/some-cool-test-refactors
# gtt=dc/test/integration-test
 
# gr=dc/refactor/db-deez
# grr=dc/refactor/something-totally-awesome
 
# #these arrays can all be used with `gitar $rg | gitlist "git pull origin -=-="`
# # r for array
# rg=($g $gg $ggg)
# rt=($gt $gtt)
# rh=($gh)
# rr=($gr $grr)
# ra=(${rg[@]} ${rt[@]} ${rh[@]} ${rr[@]})
 
# also, you can use
#   `gls [user] | gitlist "git pull origin -=-="`
#===============================

#===============================
# Git Macros
#===============================
alias gsm="git-sync-master"
git-sync-master(){
    git checkout master &&
    git fetch origin &&
    git pull origin master &&
    git checkout $1 &&
    git rebase master; }

alias gri="git-rebase-int"
git-rebase-int() { git rebase -i HEAD~$1 }


#===============
# gull
# gync
# gush
# gushforce
#
# mostly using this now
#   really easy to use, 
#   with bash arrays for branch lists
#===============
gull() { gitar $* | gitlist "git pull --rebase origin -=-=; if [ \"\$?\" -ne 0 ]; then echo [[COULD NOT PULL]] -=-=; git rebase --abort; fi;" }
gync() { gitar $* | gitlist "git rebase master; if [ \"\$?\" -ne 0 ]; then echo [[COULD NOT REBASE]] -=-=; git rebase --abort; fi;" }
gush() { gitar $* | gitlist "git push origin -=-=; if [ \"\$?\" -ne 0 ]; then echo [[COULD NOT PUSH]] -=-=; fi; "}
gushforce() { gitar $* | gitlist "git push --force origin -=-=; if [ \"\$?\" -ne 0 ]; then echo [[COULD NOT FORCE PUSH]] -=-=; fi; "}
 
#===============
# gitar 
# gitlist
#===============
# make sure you start on a branch that's not master!
#   if your script uses gwip/grewip (like grbsync)
# removing the wip commit from every rebased branch is a pain
#===============
gitlist() { xargs -I -=-= sh -c "git checkout -=-=; $@"; }
gls() {
  # swap $1 & $2?
  git branch $2 |
    grep "$1" |
    sed "s/^.*\\($1\\/.*\\)$/\\1/"; }
 
glstatus() { gls | gitlist "git status"; }
glspull() {
  glspattern=$1
  glsremote=$2
 
  # TODO: filter out the local and up to date branches
  gls $glspattern | gitlist "git pull $glsremote -=-="; }
 
# takes an array arg and
#   joins it with newlines basically
# can be piped to gitlist
gitar() { echo $* | xargs -n1 echo }
 
#===============
# gwip & grewip are really cool
#   & allow you to not
#===============
# make sure you start on a branch that's not master!
#   if your script uses gwip/grewip (like grbsync)
#===============
 
gwip() {
  gwipname=${1:-wip}-`date +%s`
  git add -A;
  git ls-files --deleted -z |
    xargs -0 -I {} git rm {};
  git commit -m $gwipname;
  echo $gwipname; }
 
grewip() {
  git log -n 1 |
    grep -q -c $1 &&
      git reset HEAD~1; }
 
#===============
# but these are cool too,
# 
# especially gbrsync
#===============
# make sure you start on a branch that's not master!
#   if your script uses gwip/grewip (like grbsync)
#===============
 
gitbruser() {
  git branch $2 |
    grep "$1" |
    sed "s/^.*\\($1\\/.*\\)$/\\1/"; }
 
gbrdc() { gitbruser dc $1 }
gbrsdc() { gbrdc --no-merged | rgs git checkout -=-=; }
 
gbrsync() {
  if [ $# -eq 0 ] ; then
    echo 'user branch folder required (e.g. dc)'
    return 0
  fi
 
  gbsfolder=$1
  gbsremote=${2:-origin}
  gbshead=${3:-master}
 
  # WIP_saved against the current branch
  gbscur=$(gcurbr)
  gbswip=$(gwip)
 
  # TODO: backup branches?
 
  git checkout $gbshead
  git fetch $gbsremote
  git pull $gbsremote $gbshead
[1;5A] 
  # TODO: split up into multiple functions 4 xargs
  gitbruser $gbsfolder --no-merged |
    xargs -I -=-= sh -c "git checkout -=-=; git rebase $gbshead; if [ \"\$?\" -ne 0 ]; then git rebase --abort; fi;"
  gch $gbscur
  grewip $gbswip;
}
 
gcurbr-ref(){ git symbolic-ref -q HEAD; }
gcurbr() { git rev-parse --abbrev-ref HEAD; }
 
gtrybe() {
  # this one's probably not working at the moment
  # shell functions don't work with xargs
 
  # tries to rebase; saves WIP branch;
  #   always resets, but rebase will stick
  #   if there's no conflicts
  gtrybr=$1
  gtryhead=$2
 
  git checkout $gtrybr
  git rebase $gtryhead;  # assume gtrybr has fetched/pulled
 
  if [ "$?" -ne 0 ]; then
    git rebase --abort
    echo Resetting `gcurbr`: couldnt rebase $gtrybr.
  fi;
}

#!/bin/sh -x
###git name-rev is fail
#CURRENT=`git branch | grep '\*' | awk '{print $2}'`
#git checkout master
#git fetch
#git pull origin master
#git checkout ${CURRENT}
#git rebase master

#https://gist.github.com/cadams500/1902385
# sync local tags with remote
#git tag -l | xargs git tag -d
#git fetch

#git remove local merged branches
#git branch --merged master | grep -v 'master$' | xargs git branch -d

# git branches by date
#alias git-branches-by-date='git branch | xargs -n1 ~/bin/branch-date | sort'

# # Rebase all branches on top of origin/master (or origin/staging for staging)
# # https://github.com/mikemcquaid/scripts/blob/master/git-rebase-all-branches
# #!/bin/sh

# GIT_CURRENT_BRANCH=$(git symbolic-ref HEAD|sed -e 's/refs.heads.//')

# git fetch --all

# git checkout staging && git rebase origin/staging
# for i in $(git branch|egrep -v '\*|staging')
# do
#     git checkout $i && git rebase origin/master
# done

# git checkout $GIT_CURRENT_BRANCH

#http://stackoverflow.com/questions/2928584/how-to-grep-search-committed-code-in-the-git-history
#
#To search for commit content
#(i.e., actual lines of source, as opposed to commit messages and the like), what you need to do is:

# git grep <regexp> $(git rev-list --all)
# This will grep through all your commit text for regexp.

# Here are some other useful ways of searching your source:

# Search working tree for text matching regular expression regexp:

# git grep <regexp>
# Search working tree for lines of text matching regular expression regexp1 or regexp2:

# git grep -e <regexp1> [--or] -e <regexp2>
# Search working tree for lines of text matching regular expression regexp1 and regexp2, reporting file paths only:

# git grep -e <regexp1> --and -e <regexp2>
# Search working tree for files that have lines of text matching regular expression regexp1 and lines of text matching regular expression regexp2:

# git grep -l --all-match -e <regexp1> -e <regexp2>
# Search all revisions for text matching regular expression regexp:

# git grep <regexp> $(git rev-list --all)
# Search all revisions between rev1 and rev2 for text matching regular expression regexp:

# git grep <regexp> $(git rev-list <rev1>..<rev2>)

#===============================
# Push/Pop & Shift/Unshift
#===============================
bpush() { arr=("${arr[@]}" "$1") }
bshift() { arr=("$1" "${arr[@]}") }

bpop() {
  i=$(expr ${#arr[@]} - 1)
  placeholder=${arr[$i]}
  unset arr[$i]
  arr=("${arr[@]}") }
bunshift() {
  placeholder=${arr[0]}
  unset arr[0]
  arr=("${arr[@]}") }

#==========================
# Join Arrays
#==========================
#join() {
#  JOIN_ARRAY_DEFAULT_DELIMITER="\n"
#  join-array=$1
#  join-text=${2:-''}
#  ${join-array]
#}

#==========================
# Flatten Arrays
#==========================

#==========================
# Split Strings
#==========================

#===============================
# Alias Functions
#===============================
insert-alias(){
  #file=$1; anchor=$2; name=$3; cmd=$4;
  echo "==[ INSERTING ALIAS ]=="
  echo "Searching for '$2' in $1"
  alicmd="alias $3=$4"
  awk-insert-below-and-replace $1 $2 $alicmd 1> /dev/null; }

EMACS_APALI_ANCHOR=";;;___"
EMACS_BINDKEYS_FILE="$DFE/support/bindkeys.el.bak"

emacs-bindkey-insert(){
  file=$1; anchor="$EMACS_APALI_ANCHOR$2"; key=$3; defun=$4;
  cmd="(global-set-key (kbd \"$key\") '$defun)"
  echo $cmd
  awk-insert-below-and-replace $file $anchor $cmd 1> /dev/null
}

emacs-bindkey-anchors(){ list-anchors $EMACS_BINDKEYS_FILE EMACS_APALI_ANCHOR; }

# can use sed but need to escape chars
list-anchors(){ file=$1; anchor=$2;
    cat $file | grep -e $anchor | awk "{ gsub(/^$anchor/, \"\"); print }"; }

#cat $DFE/support/bindkeys.el | grep -e ';;;___' | sed s/\;\;\;___//

#===============================
# Awk Functions
#===============================
# Examples
# - http://awk.info/?EdM
# - http://awk.info/?awk1line
# - http://www.grymoire.com/Unix/Awk.html#uh-4
# - http://www.ibm.com/developerworks/library/l-awk1/

awk-insert-above(){
  file=$1; rgx=$2; str=$3;
  script="{ print (/$rgx$/ ? \"$str\\n\" : \"\") \$0 } "
  awk $script $file; }

awk-insert-below(){
  file=$1; rgx=$2; str=$3;
  script="{ print \$0 (/$rgx$/ ? \"\\n$str\" : \"\") } "
  awk $script $file; }

awk-insert-above-and-replace(){
  filefoo=`get-temp-file awk-insert`;
  awk-insert-above $@[@] > $filefoo;
  cp $file $file.bak; mv $filefoo $file; }

awk-insert-below-and-replace(){
  filefoo=`get-temp-file awk-insert`;
  awk-insert-below $@[@] > $filefoo;
  cp $file $file.bak; mv $filefoo $file; }

#===============================
# Sed Functions
#===============================
  #sed '/regex/{x;p;x;}'    #insert-above
  #sed '/regex/G'           #insert-below
  #sed '/regex/{x;p;x;G;}'  #insert-above-below

#===============================
# Mktemp Functions
#===============================
# hmmm..  probably need bash pointers
#   and seriously? f*** that right now
#copy-thru-temp(){
  #hmmmmm..  what params?  name of function & input array?
#}

get-temp-file(){
  #hmmmm, "thread" safe vars? lol .. YIKES!
  tmpfoo=`basename $1`
  tmpfile=`mktemp /tmp/${tmpfoo}.XXXXXX` || exit 1
  echo $tmpfile
}

#==========================
# SSH/MD5
#==========================

ssh-new-key() { ssh-keygen -t rsa -C $1; }

#==========================
# GPG
#==========================

gpg-verify-gz() { gzip -cd $1 | gpg --verify $2 }

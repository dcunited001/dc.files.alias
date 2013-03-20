#!/bin/bash
# shell functions for all platforms



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

#===============================
# Alias Functions
#===============================
insert-alias(){
  #file=$1; anchor=$2; name=$3; cmd=$4;
  echo "==[ INSERTING ALIAS ]=="
  echo "Searching for '$2' in $1"
  alicmd="alias $3=$4"
  awk-insert-below-and-replace $1 $2 $alicmd 1> /dev/null; }

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

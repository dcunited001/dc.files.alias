#===============================
# Common updates to dotfiles via command line
#===============================

apali_help_text=<<EOF
=== (AP)pend (ALI)as ===================================================

$> insert-alias [file] [anchor] [name] [cmd]

Inserts an alias immediately after the anchor tag.

========================================================================

$> apali-insert [file] [anchor] [text]

Insert text into a file after the anchor tag

========================================================================

$> apali_anchors [file] [anchor]

List anchors in a file that match a pattern.

========================================================================

Aliases:

* Add aliases to dotfiles:

  $> apali $NAME $CMD

* Use triple quotes to wrap alias:

  $> apali foo "'bar --opts opt1 arg1 arg2 '"

* Don't add aliases loaded in the current shell.

========================================================================

Emacs:

* Add key bindings to emacs:

  $> emali $ANCHOR $ELISP

* Add scratch messages to emacs:

  $> emali-msg $ANCHOR $MSG

========================================================================
EOF


APALI_REGEX=$(printf '%q' '#__APALI__#')

apali-insert() {
  if [ -n $3 ]; then echo $apali_help_text; fi;
  file=$1; anchor=$2; text=$3;
  awk-insert-below-and-replace $file $anchor $text 1> /dev/null
}

insert-alias(){
  #file=$1; anchor=$2; name=$3; cmd=$4;
  echo "==[ INSERTING ALIAS ]=="
  echo "Searching for '$2' in $1"
  if [ -n $3 ]; then echo apali_help_text; fi;
  alicmd="alias $3=$4"
  awk-insert-below-and-replace $1 $2 $alicmd 1> /dev/null;
}

# can use sed but need to escape chars
apali_anchors(){ file=$1; anchor=$2;
    cat $file | grep -e $anchor | awk "{ gsub(/^$anchor/, \"\"); print }"; }

#cat $DFE/support/bindkeys.el | grep -e ';;;___' | sed s/\;\;\;___//

# awk-insert-below-and-replace(){
#   filefoo=`get-temp-file awk-insert`;
#   awk-insert-below $@[@] > $filefoo;
#   cp $file $file.bak; mv $filefoo $file; }

#==========================
# Apali - Add Aliases
#==========================

# TODO: fix apali for multiple args =/ have to use quotes
# TODO: apali needs to pass quotes.
# TODO: just change it to use sed. FML lol

alias apali="insert-alias $DFA/alias.sh $APALI_REGEX "
alias apalim="insert-alias $DFA/alias.mac.sh $APALI_REGEX "
alias apaliu="insert-alias $DFA/alias.ubu.sh $APALI_REGEX "

alias apali_anchors="apali_anchors "

#==========================
# Emali - Add to emacs inits
#==========================

EMACS_APALI_ANCHOR=";;;___"
EMACS_BINDKEYS_FILE="$DFE/support/bindkeys.el"
EMACS_INIT_FILE="$DFE/init-local.el"

emali () {
    apali-insert $EMACS_BINDKEYS_FILE $EMACS_APALI_ANCHOR$3 "(global-set-key (kbd \"$1\") $2)";
}

emali_msg() {
    tag=${2:-MSG}
    apali-insert $EMACS_INIT_FILE $EMACS_APALI_ANCHOR$tag "\"$1\"";
}

alias emali="apali-insert $EMACS_BINDKEYS_FILE $EMACS_BINDKEYS_FILE"

emacs_bindkey_anchors(){ apali_anchors $EMACS_BINDKEYS_FILE $EMACS_APALI_ANCHOR; }
emacs_init_anchors(){ apali_anchors $EMACS_INIT_FILE $EMACS_APALI_ANCHOR; }

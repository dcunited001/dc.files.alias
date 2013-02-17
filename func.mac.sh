#!/bin/bash
source $HOME/.files/alias/func.sh;

#===============================
# Search Google
#===============================
# using perl for brevity, for pure bash function:
#   http://stackoverflow.com/questions/296536/urlencode-from-a-bash-script
uriescape() { echo $_ | perl -MURI::Escape -lne 'print uri_escape($_)'; }

# site-wide codewall search via google
ggljoin() { echo "$*" | sed s/\ /+/g }

# $1 is the site, the rest is the query
#   returns the parameter needed to pass to google.com/search?q=
gglsitequery() {
  site=`uriescape site:$1`; shift;
  echo `ggljoin $site $@[@]`
}

# `open` is mac-only; use `xdg-open` on ubuntu
ggl() { query=`ggljoin "$*"`; open "https://google.com/search?q=$query"; }
gglsite() { query=`gglsitequery $*`; open "https://google.com/search?q=$query" }

#===============================
# Search Coderwall
#===============================
# search by trending tags:
cwall() { open https://coderwall.com/p/t/$1 }

# search coderwall by site-wide google search:
cwallsite() { gglsite "coderwall.com" $@[@] }

#===============================
# RVM
#===============================
rvm-current-gemset(){ rvm gemset gemdir | sed "s/.*@//"; }

link-zeus(){
  # the idea behind this function was
  #   to link to a global zeus binary
  # so it didn't need to be installed
  #   in the current gemset
  # this was to better set up for
  #   integration with rubymine
  # since rubymine expects zeus gem to be
  #   added to the bundle to run tests
  # but then running zeus binary just blows up haha
  #   and it prob wouldn't have worked anyways
  # leaving it in for reference to some of
  #   rvm's functions for future use

  curruby=$RUBY_VERSION;
  curgemset=`rvm-current-gemset`;
  curgemdir=`rvm gemset gemdir`;

  echo CURRENT RUBY:   $curruby;
  echo CURRENT GEMSET: $curgemset;
  echo CURRENT GEMDIR: $curgemdir;
  echo '[enter]'
  read;

  rvm use --default;
  defgemdir=`rvm use --default`;

  echo DEFAULT GEMDIR: $defgemdir;
  echo "link zeus to default?"
  echo '[enter]'
  read;

  lns `which zeus` $curgemdir/bin/zeus
  rvm use "$curruby@$curgemset";

  echo 'done..'
  la `which zeus`

  ##### and it don't work haha.. SMH
}

#!/bin/bash
source $HOME/.files/alias/func.sh;

#===============================
# Searching
#===============================
queryjoin() { echo "$*" | sed s/\ /+/g; }
# eventually abstract this function to work with
#   more than just +, but for now, who cares

#===============================
# Search Google
#===============================
# using perl for brevity, for pure bash function:
#   http://stackoverflow.com/questions/296536/urlencode-from-a-bash-script
uriescape() { echo $_ | perl -MURI::Escape -lne 'print uri_escape($_)'; }

# site-wide codewall search via google
ggljoin() { queryjoin $@; }

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
# Search Github
#===============================
ghubquery() { echo "https://github.com/search?ref=cmdform&q=$(queryjoin $*)"; }
ghubquerylang() { lang=`uriescape $1`; shift; echo "$(ghubquery $*)&l=$lang"; }

ghub() { query=`ghubquery $*`; echo $query; open $query; }            # search github
ghublang() { query=`ghubquerylang $*`; echo $query; open $query; }    # search github by language
ghubrb() { query=`ghubquerylang ruby $*`; echo $query; open $query; } # search github for ruby

#===============================
# Search Gist
#===============================
gistquery() { echo "https://gist.github.com/search?q=$(queryjoin $*)"; }
gistquerylang() { lang=`uriescape $1`; shift; echo "$(ghubquery $*)&l=$lang"; }

gists() { query=`gistquery $*`; echo $query; open $query; }
gistslang() { query=`gistquerylang $*`; echo $query; open $query; }
gistsrb() { query=`gistquerylang ruby $*`; echo $query; open $query; }

#===============================
# Search Api Dock
#===============================
adock() { url="http://apidock.com/$1"; shift; query=`queryjoin $@[@]`;
  open "$url/search?query=$query"; }
adockrb() { adock 'ruby' $@; }
adockra() { adock 'rails' $@; }
adocksp() { adock 'rspec' $@; }

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

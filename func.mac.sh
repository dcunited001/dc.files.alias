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

#
create-ssb(){
    echo "What should the Application be called (no spaces allowed e.g. GCal)?"
    read inputline
    name=$inputline

    echo "What is the url (e.g. https://www.google.com/calendar/render)?"
    read inputline
    url=$inputline

    echo "What is the full path to the icon (e.g. /Users/username/Desktop/icon.png)?"
    read inputline
    icon=$inputline

    chromePath="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    appRoot="/Applications"

    # various paths used when creating the app
    resourcePath="$appRoot/$name.app/Contents/Resources"
    execPath="$appRoot/$name.app/Contents/MacOS"
    profilePath="$appRoot/$name.app/Contents/Profile"
    plistPath="$appRoot/$name.app/Contents/Info.plist"

    # make the directories
    mkdir -p  $resourcePath $execPath $profilePath

    # convert the icon and copy into Resources
    if [ -f $icon ] ; then
        sips -s format tiff $icon --out $resourcePath/icon.tiff --resampleWidth 128 >& /dev/null
        tiff2icns -noLarge $resourcePath/icon.tiff >& /dev/null
    fi

    # create the executable
    cat >$execPath/$name <<EOF
#!/bin/sh
exec $chromePath --user-data-dir="$profilePath" "\$@"
EOF

    chmod +x $execPath/$name

    # create the Info.plist
    cat > $plistPath <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>
<plist version=”1.0″>
<dict>
<key>CFBundleExecutable</key>
<string>$name</string>
<key>CFBundleIconFile</key>
<string>icon</string>
</dict>
</plist>
EOF

}

# function to create a Site-Specific-Browser in OSX using Chrome
#   => https://gist.github.com/demonbane/1065791/raw/8d71cddae27e0f30ac7c45ea53ea1dd30ca8eb6c/makeapp.sh
#
# the browser will start in "app-mode" a single tab mode that is not very awesome
create-ssb-orig(){
    echo "What should the Application be called (no spaces allowed e.g. GCal)?"
    read inputline
    name=$inputline

    echo "What is the url (e.g. https://www.google.com/calendar/render)?"
    read inputline
    url=$inputline

    echo "What is the full path to the icon (e.g. /Users/username/Desktop/icon.png)?"
    read inputline
    icon=$inputline

    chromePath="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    appRoot="/Applications"

    # various paths used when creating the app
    resourcePath="$appRoot/$name.app/Contents/Resources"
    execPath="$appRoot/$name.app/Contents/MacOS"
    profilePath="$appRoot/$name.app/Contents/Profile"
    plistPath="$appRoot/$name.app/Contents/Info.plist"

    # make the directories
    mkdir -p  $resourcePath $execPath $profilePath

    # convert the icon and copy into Resources
    if [ -f $icon ] ; then
        sips -s format tiff $icon --out $resourcePath/icon.tiff --resampleWidth 128 >& /dev/null
        tiff2icns -noLarge $resourcePath/icon.tiff >& /dev/null
    fi

    # create the executable
    cat >$execPath/$name <<EOF
#!/bin/sh
-exec $chromePath  --app="$url" --user-data-dir="$profilePath" "\$@"
EOF

    chmod +x $execPath/$name

    # create the Info.plist
    cat > $plistPath <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>
<plist version=”1.0″>
<dict>
<key>CFBundleExecutable</key>
<string>$name</string>
<key>CFBundleIconFile</key>
<string>icon</string>
</dict>
</plist>
EOF

}


# function to create a Site-Specific-Browser in OSX using Chrome
# https://gist.github.com/demonbane/1065791/raw/8d71cddae27e0f30ac7c45ea53ea1dd30ca8eb6c/makeapp.sh
create-term(){
    echo "What should the Terminal be called (e.g. T1,T2,etc)"
    read inputline
    name=$inputline

    echo "What is the Initial Command (e.g. cd /project/path/; emacs .)?"
    read inputline
    cmd=$inputline

    echo "What is the Label (e.g. Emacs)?"
    read inputline
    label=$inputline

    echo "What is the full path to the icon (e.g. /Users/username/Desktop/icon.png)?"
    read inputline
    icon=$inputline

    #chromePath="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    #appRoot="/Applications"

    # various paths used when creating the app
    resourcePath="$appRoot/$name.app/Contents/Resources"
    execPath="$appRoot/$name.app/Contents/MacOS"
    profilePath="$appRoot/$name.app/Contents/Profile"
    plistPath="$appRoot/$name.app/Contents/Info.plist"

    # make the directories
    mkdir -p  $resourcePath $execPath $profilePath

    # convert the icon and copy into Resources
    if [ -f $icon ] ; then
        sips -s format tiff $icon --out $resourcePath/icon.tiff --resampleWidth 128 >& /dev/null
        tiff2icns -noLarge $resourcePath/icon.tiff >& /dev/null
    fi

    # create the executable
    cat >$execPath/$name <<EOF
#!/bin/sh
exec $chromePath  --app="$url" --user-data-dir="$profilePath" "\$@"
EOF

    chmod +x $execPath/$name

    # create the Info.plist
    cat > $plistPath <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>
<plist version=”1.0″>
<dict>
<key>CFBundleExecutable</key>
<string>$name</string>
<key>CFBundleIconFile</key>
<string>icon</string>
</dict>
</plist>
EOF

}

backup-plist () {
  cp $1 .
  plutil -convert xml1 -o $1.xml $1 }

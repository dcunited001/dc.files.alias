source $HOME/.files/alias/alias.sh

#typical mac ish
export USRPREF=$HOME/Library/Preferences

#emacs
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

#opening urls
alias urlch="open -a '/Applications/Google Chrome.app'"
alias urlfi="open -a '/Applications/Firefox.app'"

#saves iterm profiles
alias save-iterm="cp Library/Preferences/com.googlecode.iterm2.plist ~/dotfiles/iterm/"

#brew
alias brin='brew install'
alias brup='brew update'
alias brupgrade='brew update && brew upgrade'

#keyremap (maybe just add to path?)

alias vkd="cd '$KMAPPRIV'"
alias vk="vim ~/Library/Application\ Support/KeyRemap4MacBook/private.xml"
alias keyremap_cli='/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli'
alias kmap_reload='keyremap_cli reloadxml'
export KMAPPRIV="$HOME/Library/Application Support/KeyRemap4MacBook/"
export KMAPPREF="$HOME/Library/Preferences/org.pqrs.KeyRemap4MacBook.plist"
export KMAPPREFTOUCH="$HOME/Library/Preferences/org.pqrs.KeyRemap4MacBook.multitouchextension.plist"
export KMAPPREFPC="$HOME/Library/Preferences/org.pqrs.PCKeyboardHack.plist"

#==========================
# MISC APPLICATIONS
#==========================
alias str='open -a SourceTree'

#==========================
# OSX NETWORKING
#==========================
alias dnsflush="dscacheutil -flushcache"
# show approved firewall apps - requires sudo
#alias firewall_trusted_apps='sudo ./socketfilterfw -l | grep TRUSTEDAPPS'

#==========================
# CRYPTO
#==========================
# after installing GNU coreutils with:
#   `brew install coreutils`
#alias md5sum="gmd5sum" # just ended up linking it

#==========================
# REDIS
#==========================
alias rdstart="redis-server /usr/local/etc/redis.conf"
alias rdsvc_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"
alias rdsvc_create="ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents"

#==========================
# ELASTIC SEARCH
#==========================
alias esstart="elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml"
alias essvc_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist"
alias essvc_create="ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents"

#==========================
# POSTGRESQL
#==========================
#alias pg_connect='psql -U root ... '
alias pgstart='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias pgstart2='postgres -D /usr/local/var/postgres'

#alias pg_svc_create="" #cp /usr/local/Cellar/postgresql/9.0.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/
alias pgsvc_start="launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist"
alias pginit_db="initdb /usr/local/var/postgres"

#pg admin:
#alias pg_createuser='createuser [name] -s'
#alias pg_restore='psql [dbname] < [infile]'

#note: with brew, default postgres user is your mac user!!
#  \l    - list databases
#  \du   - list users

# pg extensions:
#   SELECT * FROM pg_available_extensions;
#   CREATE EXTENSION [extension name];

#resources:
#http://www.thegeekstuff.com/2009/04/15-practical-postgresql-database-adminstration-commands/
#http://tammersaleh.com/posts/installing-postgresql-for-rails-3-1-on-lion

# If you use -E option when doing issuing a "\di" command in psql it will
#   show you the query that it performs to list the indexes.
# psql [database] -E;
# \di, etc

#==========================
# MYSQL
#==========================
#  * http://dev.mysql.com/doc/refman/5.5/en/mysql-install-db.html
#  * http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html

alias mysql_svc_create="ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents"
alias mysql_svc_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias mysql_start="mysql.server start"
alias mysql_connect="mysql -uroot"

# Other mysql notes:
# Set up databases to run AS YOUR USER ACCOUNT with:
#    unset TMPDIR; mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
# To set up base tables in another folder, or use a different user to run mysqld, view the help for mysql_install_db:
#    mysql_install_db --help
# To run as, for instance, user "mysql", you may need to `sudo`:
#    sudo mysql_install_db ...options...
# A "/etc/my.cnf" from another install may interfere with a Homebrew-built server starting up correctly.

#__APALI__#

#Private finance management with Saldomat
asino is a small rails project that helps users of Saldomat to manage their private finances, targeted towards customers of German banks. It receives account transactions from Saldomats RSS feeds, so these need to be enabled in Saldomat. asino is intended to run on a local machine, not a server that is accessible from the internet.

Screenshots
github.com/agehret/asino/raw/master/public/images/screenshots/items_small.png

github.com/agehret/asino/raw/master/public/images/screenshots/overview_small.png

github.com/agehret/asino/raw/master/public/images/screenshots/course_small.png

##Getting Started
clone the app code from github: git clone git://github.com/agehret/asino.git

run gem install bundler

run bundle install

run rake db:create

run rake db:migrate

start your local server

##Prerequisites
MYSQL

Ruby 1.9.2

Rails 3.0.9

Firefox or Chrome or Safari (IE and Windows has not been tested)

##Scheduled Tasks
To enable automatic sync from Saldomat to asino, edit crontab (in Terminal, type “crontab -e”) and add

<tt>*/15 *  *    *     *    cd [PATH_TO_YOUR_ASINO_INSTALLATION] && /usr/bin/rake RAILS_ENV=production  asino:get</tt>
e.g.:

<tt>*/15 *  *    *     *    cd /Users/your.name/Railsapps/asino && /usr/bin/rake RAILS_ENV=production  asino:get</tt>
This will sync asino from Saldomat every 15 minutes.


##Author
Andreas Gehret

##Copyright
Copyright © 2011 agehret - Andreas Gehret, released under the MIT license

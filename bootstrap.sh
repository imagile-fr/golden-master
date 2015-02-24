#!/usr/bin/env bash

# default locale
echo 'LC_ALL="en_US.utf8"' > /etc/default/locale

# add fr_FR locale
sudo locale-gen fr_FR.UTF-8
sudo update-locale

sudo apt-get update
sudo apt-get install -y php5-gd php5-curl
sudo apt-get install -y libmysql-ruby libmysqlclient-dev

cd /vagrant && bundle
rbenv rehash

sudo cp /vagrant/templates/default /etc/apache2/sites-available/default
sudo service apache2 restart

mysql -u"root" -p"root" -e ";
CREATE DATABASE IF NOT EXISTS blog;
"
if [ -f /vagrant/app/config/sql/seeds/dump.sql ];
then
  mysql -u"root" -p"root" blog < /vagrant/app/Config/sql/seeds/dump.sql
fi

find /vagrant -type f -name "*.default" | while read file
do
  cp $file ${file%.*}
done

# PhantomJS
pushd /usr/local/share
  sudo wget https://phantomjs.googlecode.com/files/phantomjs-1.9.0-linux-x86_64.tar.bz2
  sudo tar xjf phantomjs-1.9.0-linux-x86_64.tar.bz2
  sudo ln -s /usr/local/share/phantomjs-1.9.0-linux-x8664/bin/phantomjs /usr/local/share/phantomjs
  sudo ln -s /usr/local/share/phantomjs-1.9.0-linux-x8664/bin/phantomjs /usr/local/bin/phantomjs
  sudo ln -s /usr/local/share/phantomjs-1.9.0-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
popd

#!/usr/bin/env bash

# default locale
echo 'LC_ALL="en_US.utf8"' > /etc/default/locale

# add fr_FR locale
sudo locale-gen fr_FR.UTF-8
sudo update-locale

sudo apt-get update
sudo apt-get install -y libmysql-ruby libmysqlclient-dev

# php
if [ ! -f /usr/bin/phpbrew ];
then
  sudo apt-get install -y apache2-prefork-dev
  sudo apt-get install -y libxml2-dev libbz2-dev libmcrypt-dev libxslt1-dev libltdl-dev
  curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
  chmod +x phpbrew
  sudo mv phpbrew /usr/bin/phpbrew
  phpbrew init
  source /home/vagrant/.bash_profile
  phpbrew lookup-prefix ubuntu
  sudo phpbrew install 5.3.29 +default +mysql +pdo +apxs2=/usr/bin/apxs2
  sudo phpbrew install 5.4.36 +default +mysql +pdo +apxs2=/usr/bin/apxs2
  sudo cp /vagrant/templates/php* /etc/apache2/mods-available
  sudo ln -nfs /etc/apache2/mods-available/php5.3.load /etc/apache2/mods-enabled/php5.load
else
  echo "phpbrew is already installed"
fi

if grep -Fxq "source ~/.phpbrew/bashrc" /home/vagrant/.bash_profile
then
  "phpbrew is already in ~/.bash_profile"
else
  echo "export PHPBREW_SET_PROMPT=1" >> /home/vagrant/.bash_profile
  echo "source ~/.phpbrew/bashrc" >> /home/vagrant/.bash_profile
fi

if grep -Fxq "alias php53='. /vagrant/php5.3.sh'" /home/vagrant/.bash_profile
  echo "alias php53='. /vagrant/php5.3.sh'" >> /home/vagrant/.bash_profile
fi

if grep -Fxq "alias php54='. /vagrant/php5.4.sh'" /home/vagrant/.bash_profile
  echo "alias php54='. /vagrant/php5.4.sh'" >> /home/vagrant/.bash_profile
fi

pushd /home/vagrant/.rbenv
  git fetch && git pull
popd

pushd /home/vagrant/.rbenv/plugins/ruby-build
  git fetch && git pull
popd

pushd /vagrant
  rbenv install
  rbenv rehash
  gem install bundler
  rbenv rehash
  bundle
popd
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

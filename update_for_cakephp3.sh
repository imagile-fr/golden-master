#!/bin/bash

pushd /vagrant
  php composer.phar install
popd

sudo cp /vagrant/templates/default /etc/apache2/sites-available/default
sudo service apache2 restart

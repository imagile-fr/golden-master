#!/bin/bash

sudo ln -nfs /vagrant/templates/default /etc/apache2/sites-available/default
sudo service apache2 restart
find /vagrant -type f -name "*.default" | while read file
do
  cp $file ${file%.*}
done

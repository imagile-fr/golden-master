#!/bin/bash

source ~/.phpbrew/bashrc
phpbrew switch php-5.4.36
sudo ln -nfs /etc/apache2/mods-available/php5.4.load /etc/apache2/mods-enabled/php5.load
sudo service apache2 restart

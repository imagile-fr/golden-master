#!/bin/bash

sudo phpbrew remove 5.4.36
sudo phpbrew install 5.4.36 +default +mysql +pdo +intl +apxs2=/usr/bin/apxs2
libtool --finish /home/vagrant/.phpbrew/build/php-5.4.36/libs

#!/bin/sh

env | grep LEADWIRE  > /usr/share/leadwire-portail/.env

/usr/sbin/nginx
/usr/sbin/php-fpm -F

cd /usr/share/leadwire-portail/
sudo -u nginx bin/console assets:install --env=prod
sudo -u nginx bin/console assetic:dump --env=prod
sudo -u nginx bin/console cache:clear --env=prod

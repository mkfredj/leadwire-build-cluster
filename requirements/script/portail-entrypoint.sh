#!/bin/sh

env | grep LEADWIRE  > /usr/share/leadwire-portail/.env

/usr/sbin/nginx
/usr/sbin/php-fpm -F

cd /usr/share/leadwire-portail/
sudo -u nginx bin/console assets:install --env=prod
sudo -u nginx bin/console assetic:dump --env=prod
sudo -u nginx bin/console cache:clear --env=prod

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    sudo -u nginx bin/console leadwire:install --env=prod
else
    echo "-- Not first container startup --"
fi

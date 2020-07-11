#!/bin/sh

cd /usr/share/leadwire-portail
#sudo -u nginx sh /usr/share/leadwire-portail/get_composer.sh

sudo -u nginx php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo -u nginx php composer-setup.php
sudo -u nginx php -r "unlink('composer-setup.php');"

sudo -u nginx php /usr/share/leadwire-portail/composer.phar install --no-dev --no-scripts --optimize-autoloader

setfacl -dR -m u:"nginx":rwX -m u:$(whoami):rwX /usr/share/leadwire-portail/var
setfacl -R -m u:"nginx":rwX -m u:$(whoami):rwX /usr/share/leadwire-portail/var


#!/bin/sh

version=${VERSION_LEADWIRE}
curl -LJO  -H 'Authorization: token bc9ef0f060b991031b7208211b1767d5df10da16' https://github.com/leadwire-apm/leadwire-portail/archive/v${version}.tar.gz
tar -xzvf leadwire-portail-${version}.tar.gz -C /usr/share/
rm -f leadwire-portail-${version}.tar.gz
mv /usr/share/leadwire-portail-${version} /usr/share/leadwire-portail
chown -R nginx:nginx /usr/share/leadwire-portail
cd /usr/share/leadwire-portail
#sudo -u nginx sh /usr/share/leadwire-portail/get_composer.sh

sudo -u nginx php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo -u nginx php composer-setup.php
sudo -u nginx php -r "unlink('composer-setup.php');"

sudo -u nginx php /usr/share/leadwire-portail/composer.phar install --no-dev --no-scripts --optimize-autoloader

setfacl -dR -m u:"nginx":rwX -m u:$(whoami):rwX /usr/share/leadwire-portail/var
setfacl -R -m u:"nginx":rwX -m u:$(whoami):rwX /usr/share/leadwire-portail/var


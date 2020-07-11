#!/bin/sh


if [ ! -z ${PORTAL_HOSTNAME+x} ]; then
    sed -i -e "s/auth.leadwire.io/${PORTAL_HOSTNAME}/g" /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-*.json
fi
if [ ! -z ${MANAGER_HOSTNAME+x} ]; then
    sed -i -e "s/manager.leadwire.io/${MANAGER_HOSTNAME}/g" /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-*.json
fi
if [ ! -z ${HANDLER_HOSTNAME+x} ]; then
    sed -i -e "s/reload.leadwire.io/${HANDLER_HOSTNAME}/g" /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-*.json
fi
if [ ! -z ${APM_HOSTNAME+x} ]; then
    sed -i -e "s/apm.leadwire.io/${APM_HOSTNAME}/g" /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-*.json
fi
if [ ! -z ${KIBANA_HOSTNAME+x} ]; then
    sed -i -e "s/kibana.leadwire.io/${KIBANA_HOSTNAME}/g" /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-*.json
fi

sed -i "s/leadwire\.io/${SSODOMAIN}/" /etc/lemonldap-ng/* /var/lib/lemonldap-ng/conf/lmConf-*.json

# Logging options
sed -i -e "s/^logLevel.*/logLevel=${LOGLEVEL}/" /etc/lemonldap-ng/lemonldap-ng.ini
if ! grep -q '^logger' /etc/lemonldap-ng/lemonldap-ng.ini ; then
    sed -i -e '/^logLevel/alogger = Lemonldap::NG::Common::Logger::Std' /etc/lemonldap-ng/lemonldap-ng.ini
fi

sed -i -e 's/^;checkTime.*/checkTime = 1/' /etc/lemonldap-ng/lemonldap-ng.ini


# Run the fastcgi server withing this session so that we can get logs in 
# STDOUT/STDERR
/usr/sbin/nginx
sudo -u apache /usr/libexec/lemonldap-ng/sbin/llng-fastcgi-server --foreground

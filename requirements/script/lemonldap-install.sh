#!/bin/sh

CFG_COOKIE_NAME=leadwire
CFG_DOMAIN_NAME=leadwire.io

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 set cookieName ${CFG_COOKIE_NAME}
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 set domain ${CFG_DOMAIN_NAME}



/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 set portalMainLogo leadwire/logo/leadwire-logo.jpg
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 set portalSkinBackground leadwire-bg.jpg

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1     delKey         applicationList/1sample/ test1
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1     delKey         applicationList/1sample/ test2
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1     delKey         applicationList/3documentation localdoc
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1     delKey         applicationList/3documentation officialwebsite

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -force 1 -yes 1 \
    delKey \
        locationRules/auth.leadwire.io '(?#checkUser)^/checkuser' \
	locationRules/auth.leadwire.io '(?#errors)^/lmerror/'
	
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        'locationRules/auth.leadwire.io' 'default' 'accept' \
        'locationRules/auth.leadwire.io' '^/lmerror/' 'accept' \
        'locationRules/auth.leadwire.io' '^/checkuser' '$uid eq "admin"'

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -force 1 -yes 1 \
    delKey \
        locationRules/manager.leadwire.io '(?#Configuration)^/(manager\.html|confs|$)' \
        locationRules/manager.leadwire.io '(?#Notifications)/notifications' \
        locationRules/manager.leadwire.io '(?#Sessions)/sessions'

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -force 1 -yes 1  \
    delKey \
        locationRules/manager.leadwire.io '(?#Configuration)^/(.*?\.(fcgi|psgi)/)?(manager\.html|confs/|$)' \
        locationRules/manager.leadwire.io '(?#Notifications)/(.*?\.(fcgi|psgi)/)?notifications' \
        locationRules/manager.leadwire.io '(?#Sessions)/(.*?\.(fcgi|psgi)/)?sessions'
	
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        'locationRules/manager.leadwire.io' 'default' 'accept' \
        'locationRules/manager.leadwire.io' '/sessions' '$uid eq "admin"' \
	'locationRules/manager.leadwire.io' '/notifications' '$uid eq "admin"' \
        'locationRules/manager.leadwire.io' '^/(manager\.html|confs|$)' '$uid eq "admin"'

	
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        'locationRules/kibana.leadwire.io' 'default' 'accept' \
        'locationRules/kibana.leadwire.io' '/api/sentinl' '$uid eq "admin"' \
        'exportedHeaders/kibana.leadwire.io' 'Auth-User' '$uid' \
        'exportedHeaders/kibana.leadwire.io' 'Auth-Roles' "(split('\|',(grep{/apm/} split(';',\$groups))[0]))[0]"	

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        'locationRules/grafana.leadwire.io' 'default' 'accept' \
        'locationRules/grafana.leadwire.io' '/api/sentinl' '$uid eq "admin"' \
        'exportedHeaders/grafana.leadwire.io' 'Auth-User' '$uid' \
        'exportedHeaders/grafana.leadwire.io' 'Auth-Roles' "(split('\|',(grep{/apm/} split(';',\$groups))[0]))[0]"


/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        'locationRules/apm.leadwire.io' 'default' 'accept' \
        'locationRules/apm.leadwire.io' '(?#Logout)^/logout' 'logout_sso' \
        'exportedHeaders/apm.leadwire.io' 'Auth-User' '$uid' \
        'exportedHeaders/apm.leadwire.io' 'Auth-Mail' '$mail' \
        'exportedHeaders/apm.leadwire.io' 'Auth-Roles' "(split('\|',(grep{/apm/} split(';',\$groups))[0]))[0]"

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        applicationList/applications type category \
        applicationList/applications catname Applications
		
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        applicationList/applications/apm type application \
        applicationList/applications/apm/options description "Lead Wire Portal" \
        applicationList/applications/apm/options display "auto" \
        applicationList/applications/apm/options logo "leadwire-icon.jpg" \
        applicationList/applications/apm/options name "Lead Wire Portal" \
        applicationList/applications/apm/options uri "https://apm.leadwire.io/"
		
		
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        applicationList/applications/kibana type application \
        applicationList/applications/kibana/options description "Report Server" \
        applicationList/applications/kibana/options display "auto" \
        applicationList/applications/kibana/options logo "kibana.png" \
        applicationList/applications/kibana/options name "Kibana" \
        applicationList/applications/kibana/options uri "https://kibana.leadwire.io/"


/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        applicationList/applications/grafana type application \
        applicationList/applications/grafana/options description "Report Server" \
        applicationList/applications/grafana/options display "auto" \
        applicationList/applications/grafana/options logo "grafana.png" \
        applicationList/applications/grafana/options name "Grafana" \
        applicationList/applications/grafana/options uri "https://grafana.leadwire.io/"
	
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        'locationRules/alert.leadwire.io' 'default' 'accept' \
        'exportedHeaders/alert.leadwire.io' 'Auth-User' '$uid'
		
/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        applicationList/applications/alertmanager type application \
        applicationList/applications/alertmanager/options description "Alert Server" \
        applicationList/applications/alertmanager/options display "auto" \
        applicationList/applications/alertmanager/options logo "prometheus.gif" \
        applicationList/applications/alertmanager/options name "Alert Manager" \
        applicationList/applications/alertmanager/options uri "https://alert.leadwire.io/"
	

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        ldapExportedVars uid uid \
        ldapExportedVars cn cn \
        ldapExportedVars sn sn \
        ldapExportedVars mobile mobile \
        ldapExportedVars mail mail \
        ldapExportedVars givenName givenName \
        ldapExportedVars group group 

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    set \
        ldapGroupBase 'ou=roles,dc=leadwire,dc=io' \
        ldapGroupObjectClass organizationalRole \
        ldapGroupAttributeName roleOccupant \
        ldapGroupAttributeNameGroup dn \
        ldapGroupAttributeNameSearch 'cn ou' \
        ldapGroupAttributeNameUser dn \
        ldapGroupRecursive 1

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    set \
        portal https://auth.leadwire.io \
        mailUrl https://auth.leadwire.io/resetpwd \
        registerUrl https://auth.leadwire.io/register \
        https 1 \
        securedCookie 1


/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 set captcha_register_enabled 1	

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 set globalStorage "Apache::Session::LDAP"

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    set \
        authentication LDAP \
        userDB LDAP \
        passwordDB LDAP \
        registerDB LDAP \
        ldapServer "ldap://leadwire-ldap" \
        ldapPort 389 \
        managerDn 'cn=admin,dc=leadwire,dc=io' \
        managerPassword admin \
        ldapBase 'ou=people,dc=leadwire,dc=io'

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli -yes 1 \
    addKey \
        globalStorageOptions ldapBindDN "cn=admin,dc=leadwire,dc=io" \
        globalStorageOptions ldapConfBase "ou=sessions,dc=leadwire,dc=io" \
        globalStorageOptions ldapServer "ldap://leadwire-ldap:389" \
        globalStorageOptions ldapBindPassword admin

/usr/share/lemonldap-ng/bin/lemonldap-ng-cli save > /etc/lemonldap-ng/save-config.$$.json



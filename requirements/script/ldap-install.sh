CFG_LDAP_DIR=/requirements/ldap/
CFG_ldapPassword=admin
CFG_managerPassword=admin

passwordcontent=$(slappasswd -h {SSHA} -s ${CFG_ldapPassword}) && sed "s#__replace__#${passwordcontent}#g" ${CFG_LDAP_DIR}/db.ldif.tpl  > ${CFG_LDAP_DIR}/db.ldif
ldapmodify -Y EXTERNAL  -H ldapi:/// -f ${CFG_LDAP_DIR}/db.ldif
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap:ldap /var/lib/ldap/*
ldapadd -w ${CFG_ldapPassword} -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -w ${CFG_ldapPassword} -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif 
ldapadd -w ${CFG_ldapPassword} -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
ldapadd -w ${CFG_ldapPassword} -x -D "cn=admin,dc=leadwire,dc=io" -f ${CFG_LDAP_DIR}/base.ldif

## ADMIN
passwordadmin=$(slappasswd -h {SSHA} -s ${CFG_managerPassword}) && sed "s#__replace__#${passwordadmin}#g" ${CFG_LDAP_DIR}/admin.ldif.tpl  > ${CFG_LDAP_DIR}/admin.ldif
ldapadd -w ${CFG_ldapPassword} -x -D "cn=admin,dc=leadwire,dc=io" -f ${CFG_LDAP_DIR}/admin.ldif

## ROLES
ldapadd -w ${CFG_ldapPassword} -x -D "cn=admin,dc=leadwire,dc=io" -f ${CFG_LDAP_DIR}/role.ldif

## TEST USERS
ldapadd -w ${CFG_ldapPassword} -x -D "cn=admin,dc=leadwire,dc=io" -f ${CFG_LDAP_DIR}/testuser.ldif



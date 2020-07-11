#!/bin/sh
ulimit -n 1024 && /usr/sbin/slapd -u ldap -h 'ldap:/// ldapi:///' -d 0  


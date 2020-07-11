#!/bin/sh

version=1.3.9
curl -LJO  -H 'Authorization: token bc9ef0f060b991031b7208211b1767d5df10da16' https://github.com/leadwire-apm/leadwire-portail/archive/v${version}.tar.gz
tar -xzvf leadwire-portail-${version}.tar.gz -C /usr/share/
rm -f leadwire-portail-${version}.tar.gz
mv /usr/share/leadwire-portail-${version} /usr/share/leadwire-portail
cd /usr/share/leadwire-portail
npm install
npm install -g forever




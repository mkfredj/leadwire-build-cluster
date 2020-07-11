#!/bin/sh

version=${VERSION_PORTAIL}
git clone --depth=50 --branch=evol/lot3 https://leadwire-apm:${GIT_TOKEN}@github.com/leadwire-apm/leadwire-portail.git /usr/share/leadwire-portail

cd /usr/share/leadwire-portail
npm install
npm install -g forever




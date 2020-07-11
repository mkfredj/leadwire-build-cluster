FROM centos/systemd

MAINTAINER "Wassim Dhib" <wassim.dhib@leadwire.io>

LABEL org.label-schema.schema-version="leadwire-portail-1.3" \
    org.label-schema.name="Lead Wire APM" \
    org.label-schema.vendor="Lead Wire SAS" \
    org.label-schema.license="Lead Wire Private Use" \
    org.label-schema.build-date="20200502"

##Update
RUN yum -y update

## TOOLS
RUN yum -y install sudo unzip crontabs  

#Repos
RUN yum install epel-release -y

# NODE
RUN yum install -y nodejs
RUN yum install -y openssl

ARG VERSION_PORTAIL
ARG GIT_TOKEN

ADD /requirements/ /requirements/
RUN sh /requirements/script/socket-install.sh


## OPENSSL
RUN mkdir -p /certificates/ && openssl req \
    -new \
    -newkey rsa:2048 \
    -days 3650 \
    -nodes \
    -x509 \
    -subj "/C=FR/ST=Paris/L=Paris/O=leadwire/CN=*.leadwire.io" \
    -keyout /certificates/server.key \
    -out /certificates/server.crt && openssl x509 -in /certificates/server.crt -out /certificates/server.pem -outform PEM

CMD ["forever", "/usr/share/leadwire-portail/server.js"]


FROM centos:7
ARG GIT_TOKEN
RUN yum install -y git
RUN git clone --depth=50 --branch=evol/lot3 https://leadwire-apm:${GIT_TOKEN}@github.com/leadwire-apm/leadwire-portail.git /leadwire-portail


FROM centos:7

ARG VERSION_PORTAIL
ARG BUILD_DATE

MAINTAINER "Wassim Dhib" <wassim.dhib@leadwire.io>

LABEL org.label-schema.schema-version="leadwire-portail-${VERSION_PORTAIL}" \
    org.label-schema.name="Lead Wire APM" \
    org.label-schema.vendor="Lead Wire SAS" \
    org.label-schema.license="Private Use" \
    org.label-schema.build-date="${BUILD_DATE}"

## TOOLS
RUN yum -y install sudo crontabs  

#Repos
RUN yum install epel-release -y

# NODE
RUN yum install -y nodejs
RUN yum install -y openssl

ARG VERSION_PORTAIL
ARG GIT_TOKEN

ADD /requirements/ /requirements/
COPY --from=0 /leadwire-portail /usr/share/leadwire-portail/

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


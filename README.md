# leadwire-docker-build

build docker image

```

docker build --build-arg ldappassword=admin --build-arg managerPassword=admin --build-arg cookie=leadwire --build-arg domain=leadwire.io --build-arg gitpassword=changeit  -f Dockerfile-opendistro .

docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it -p 80:80 -p 389:389 -p 443:443 -p 8008:8008 -p 8009:8009 -p 9000:9000 docker.io/leadwire/leadwire-apm:opendistro-1.3
```

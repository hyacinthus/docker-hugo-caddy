FROM alpine:3.5
MAINTAINER Hyacinthus <hyacinthus@gmail.com>

LABEL caddy_version="0.9.5" architecture="amd64"

ARG plugins=git%2Chugo

RUN apk add --no-cache openssh-client git tar curl

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && git config --global fetch.recurseSubmodules true

EXPOSE 80 443 2015
VOLUME /root/.caddy
WORKDIR /hugo

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]

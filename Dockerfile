FROM alpine:3.5
MAINTAINER Hyacinthus <hyacinthus@gmail.com>

LABEL caddy_version="0.9.5" architecture="amd64"

ARG plugins=git%2Chugo
ARG hugo_version=0.19

RUN apk add --no-cache openssh-client git tar curl

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://github.com/spf13/hugo/releases/download/v${hugo_version}/hugo_${hugo_version}_Linux-64bit.tar.gz" \
    | tar --no-same-owner -C /tmp -xz hugo_${hugo_version}_linux_amd64/hugo_${hugo_version}_linux_amd64 \
 && mv /tmp/hugo_${hugo_version}_linux_amd64/hugo_${hugo_version}_linux_amd64 /usr/bin/hugo \
 && chmod 0755 /usr/bin/hugo \
 && git config --global fetch.recurseSubmodules true \
 && mkdir -p /www/public


EXPOSE 80 443 2015
VOLUME /root/.caddy
WORKDIR /www

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]

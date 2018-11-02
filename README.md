# Hugo with Caddy


A [Docker](http://docker.com) image for Hugo with [Caddy](http://caddyserver.com) webserver. This image includes the [git](http://caddyserver.com/docs/git) plugin.  Plugins can be configured via the `plugins` build arg.

[![](https://images.microbadger.com/badges/image/muninn/hugo-caddy.svg)](https://microbadger.com/images/muninn/hugo-caddy "Get your own image badge on microbadger.com")
[![Build Status](https://semaphoreci.com/api/v1/muninn/docker-hugo-caddy/branches/master/shields_badge.svg)](https://semaphoreci.com/muninn/docker-hugo-caddy)

## Getting Started

```sh
$ docker run -d -p 2015:2015 muninn/hugo-caddy
```

Point your browser to `http://127.0.0.1:2015`.

> Be aware! If you don't bind mount the location certificates are saved to, you may hit Let's Encrypt rate [limits](https://letsencrypt.org/docs/rate-limits/) rending further certificate generation or renewal disallowed (for a fixed period)! See "Saving Certificates" below!

### Saving Certificates

Save certificates on host machine to prevent regeneration every time container starts.
Let's Encrypt has [rate limit](https://community.letsencrypt.org/t/rate-limits-for-lets-encrypt/6769).
```sh
$ docker run -d \
    -v $(pwd)/Caddyfile:/etc/Caddyfile \
    -v $HOME/.caddy:/root/.caddy \
    -p 80:80 -p 443:443 \
    muninn/hugo-caddy
```


Here, `/root/.caddy` is the location *inside* the container where caddy will save certificates.

Additionally, you can use an *environment variable* to define the exact location caddy should save generated certificates:

```sh
$ docker run -d \
    -e "CADDYPATH=/etc/caddycerts" \
    -v $HOME/.caddy:/etc/caddycerts \
    -p 80:80 -p 443:443 \
    muninn/hugo-caddy
```

Above, we utilize the `CADDYPATH` environment variable to define a different location inside the container for
certificates to be stored. This is probably the safest option as it ensures any future docker image changes don't interfere with your ability to save certificates!

### Using git sources

Caddy can serve sites from git repository using [git](https://caddyserver.com/docs/git) plugin.


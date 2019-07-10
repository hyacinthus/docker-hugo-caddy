# Hugo with Caddy

A [Docker](http://docker.com) image for Hugo with
[Caddy](http://caddyserver.com) webserver. This image includes the
[git](http://caddyserver.com/docs/git) plugin. Plugins can be configured via the
`plugins` build arg.

[![image size](https://images.microbadger.com/badges/image/muninn/hugo-caddy.svg)](https://microbadger.com/images/muninn/hugo-caddy 'Get your own image badge on microbadger.com')
[![Build Status](https://semaphoreci.com/api/v1/muninn/docker-hugo-caddy/branches/master/shields_badge.svg)](https://semaphoreci.com/muninn/docker-hugo-caddy)

## Getting Started

```sh
docker run -d -p 2015:2015 muninn/hugo-caddy
```

Point your browser to `http://127.0.0.1:2015` if you run docker locally, or
`http://yourdomain:2015` if deployed on remote server.

## Use Docker Compose

Copy the `docker-compose.yml.example` to `docker-compose.yml` and change the
`PORT` and `REPO` in it. Then:

```sh
docker-compose up -d
```

## Serve your hogo repo

Just change the REPO Env to your hogo repo address.

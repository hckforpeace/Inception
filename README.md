<div align="center">

# Inception

**A multi-service WordPress infrastructure, built from scratch with Docker.**

NGINX · WordPress + PHP-FPM · MariaDB — each in its own container, wired together with Docker Compose.

</div>

---

Inception is a [42 School](https://42.fr) system-administration project. The goal is to set up a small but complete web infrastructure entirely inside Docker containers, using a custom `docker-compose` configuration. Every service runs in its **own container, built from its own Dockerfile** — no pulling ready-made application images from Docker Hub.

The stack serves a WordPress site over HTTPS only, reverse-proxied by NGINX, with content stored in a MariaDB database. Data persists across restarts through Docker volumes.

## Architecture

```
                    :443 (TLS)
        ┌──────────────────────────────┐
client ─┤            NGINX              │  ← only public entrypoint
        │   TLSv1.2 / TLSv1.3, no 80    │
        └───────────────┬──────────────┘
                        │ fastcgi :9000
        ┌───────────────┴──────────────┐
        │      WordPress + PHP-FPM      │
        └───────────────┬──────────────┘
                        │ mysql :3306
        ┌───────────────┴──────────────┐
        │           MariaDB             │
        └──────────────────────────────┘
```

| Service       | Base image      | Role                                                        | Port  |
| ------------- | --------------- | ----------------------------------------------------------- | ----- |
| **nginx**     | `debian:bullseye` | TLS termination, reverse proxy, the only exposed container | `443` |
| **wordpress** | `debian:buster`   | WordPress 6.0 served via PHP-FPM, configured with WP-CLI    | `9000` (internal) |
| **mariadb**   | `debian:buster`   | Persistent database backing WordPress                       | `3306` (internal) |

Only NGINX is reachable from the host. WordPress and MariaDB talk to each other over a private Docker network and are never published directly.

## Project structure

```
.
├── Makefile                      # build / up / down / clean targets
├── secrets/                      # credentials kept out of the images
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
    ├── .env                      # domain, DB names, users (not committed in prod)
    ├── docker_compose.yml        # orchestrates the three services
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/             # default vhost, nginx.conf, index.html
        ├── wordpress/
        │   ├── Dockerfile
        │   └── conf/script.sh    # WP-CLI bootstrap (wp-config + DB link)
        └── mariadb/
            ├── Dockerfile
            └── conf/             # script.sh, 50-server.cnf, mysql.cnf
```

## Getting started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and the Docker Compose plugin
- `make`
- A domain name pointing at the host. For the school setup this is `login.42.fr` (e.g. `pbeyloun.42.fr`), mapped to `127.0.0.1` in `/etc/hosts`:

  ```
  127.0.0.1   pbeyloun.42.fr
  ```

### Configuration

Secrets and environment values live outside the Dockerfiles:

- `srcs/.env` — domain name, database name, database users.
- `secrets/` — database passwords and WordPress admin credentials, mounted at build/run time rather than baked into the images.

> [!IMPORTANT]
> Never commit real passwords. Keep `secrets/` and `srcs/.env` out of version control and provide them per-environment.

### Build and run

```bash
make            # build images and start the stack
```

Then open <https://pbeyloun.42.fr> in your browser. Because the certificate is self-signed, your browser will warn on first visit — accept it to continue.

### Common commands

```bash
make          # build images and bring the stack up
make down     # stop and remove the containers
make clean    # remove containers, images and volumes
make re       # rebuild everything from scratch
```

> [!NOTE]
> The `Makefile` wraps `docker compose -f srcs/docker_compose.yml`. You can run those commands directly if you prefer.

## How it works

- **NGINX** is the single entrypoint. It listens on `443` with a self-signed certificate (generated at build time via `openssl`), enforces `TLSv1.2`/`TLSv1.3`, and forwards `.php` requests to the WordPress container over FastCGI on port `9000`. Plain HTTP on `80` is redirected to HTTPS.
- **WordPress** runs on PHP-FPM listening on `wordpress:9000`. On startup, `script.sh` uses **WP-CLI** to generate `wp-config.php` and connect WordPress to the database using the credentials from the environment.
- **MariaDB** initializes on first boot: its `script.sh` binds the server to all interfaces, creates the WordPress database and user, and sets the root password. The data directory lives on a Docker volume so content survives restarts.

## TLS / HTTPS

The NGINX image generates a self-signed certificate during build:

```
/etc/nginx/ssl/inception.crt
/etc/nginx/ssl/inception.key
```

This is expected for the project — production deployments should replace it with a certificate from a trusted CA.

> [!WARNING]
> The default credentials and self-signed certificate are for local development and the 42 evaluation only. Do not reuse them anywhere public.

## Status

This repository is a work in progress. Several files (`Makefile`, `srcs/docker_compose.yml`, `srcs/.env`) are still being filled in, and a few configs contain placeholder or commented-out blocks. The individual service Dockerfiles and bootstrap scripts are functional and reflect the intended architecture above.

# Dockerized Nginx with SSL

This project demonstrates how to set up Nginx in a Docker container with SSL support using Let's Encrypt certificates managed by Certbot.
### Prerequisites
- Docker and Docker Compose installed on your machine.
- A registered domain name pointing to your server's IP address.
- Ports 80 and 443 open on your server for HTTP and HTTPS traffic.


### Obtain SSL Certificate (First Time)

```sh
docker compose up -d nginx app1 app2
```

```sh
docker compose run --rm certbot certonly \
    --webroot \
    --webroot-path=/var/www/certbot \
    --email you@example.com \
    --agree-tos \
    --no-eff-email \
    -d example.com -d www.example.com
```


```sh
docker compose restart nginx
```

### Add cron on host:

```sh
0 3 * * * docker compose run --rm certbot renew && docker compose restart nginx
```
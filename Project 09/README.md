## Obtain SSL Certificate (First Time)

docker compose up -d nginx app1 app2


docker compose run --rm certbot certonly \
--webroot \
--webroot-path=/var/www/certbot \
--email you@example.com \
--agree-tos \
--no-eff-email \
-d example.com -d www.example.com




docker compose restart nginx


## Add cron on host:

0 3 * * * docker compose run --rm certbot renew && docker compose restart nginx
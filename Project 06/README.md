# SSL Automation for Nginx

This guide explains how to secure an **Nginx-hosted site on EC2** with HTTPS using **Let’s Encrypt (Certbot)** in a reliable, repeatable, script-based way.

>[!Warning]
>HTTPS is enabled after EC2 launch and DNS setup, not during User Data, to avoid DNS timing issues.


>[!Note]
>**You can use any linux server instead of EC2**


## Prerequisites
- A linux VM (i.e EC2 Ubuntu 24)
- Nginx installed and serving HTTP
- Domain or subdomain (example: app.domain.tech)
- DNS A record exists and resolves:
  `app.domain.tech → EC2_PUBLIC_IP`


## Install and enable Nginx

```sh
#!/bin/bash
apt update -y
apt install -y nginx
systemctl start nginx
systemctl enable nginx
```

## HTTPS Automation Script (Post-Launch)

>[!Warning]
> **Must use valid email address and domain name.**

```sh
#!/bin/bash
set -e

DOMAIN="app.domain.tech"
EMAIL="you@example.com"
WEBROOT="/var/www/$DOMAIN"

sudo apt update
sudo apt install -y certbot python3-certbot-nginx

sudo certbot --nginx \
  -d $DOMAIN \
  --non-interactive \
  --agree-tos \
  -m $EMAIL \
  --redirect

sudo nginx -t
sudo systemctl reload nginx
```

**Make executable:**
```sh
chmod +x enable_https.sh
```

**Run:**
```sh
./enable_https.sh
```

## Check Existing Certbot Certificates

**List all certificates:**

```sh
sudo certbot certificates
```

## Test Certificate Renewal

**Verify auto-renew is enabled:**

```sh
systemctl list-timers | grep certbot
```

**Check status:**

```sh
systemctl status certbot.timer
```

**Test renewal safely:**

```sh
sudo certbot renew --dry-run
```


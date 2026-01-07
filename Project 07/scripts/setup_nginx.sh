#!/bin/bash
set -e

NGINX_ROOT="/etc/nginx"
WEB_ROOT="/var/www"

DOMAINS=(
  "app.domain.com:index.app.html"
  "web.domain.com:index.web.html"
)


# Create common directories
sudo mkdir -p "$NGINX_ROOT/snippets"
sudo mkdir -p "$NGINX_ROOT/sites-available"
sudo mkdir -p "$NGINX_ROOT/sites-enabled"

# Copy common snippet
sudo cp conf/common.conf "$NGINX_ROOT/snippets/common.conf"

for entry in "${DOMAINS[@]}"; do
  DOMAIN="${entry%%:*}"
  INDEX_FILE="${entry##*:}"


  # Create web directory
  sudo mkdir -p "$WEB_ROOT/$DOMAIN"

  # Copy landing page
  sudo cp "landing-pages/$INDEX_FILE" "$WEB_ROOT/$DOMAIN/index.html"

  # Set ownership & permissions
  sudo chown -R "$USER:www-data" "$WEB_ROOT/$DOMAIN"
  sudo find "$WEB_ROOT/$DOMAIN" -type d -exec chmod 755 {} \;
  sudo find "$WEB_ROOT/$DOMAIN" -type f -exec chmod 644 {} \;

  # Copy nginx config
  sudo cp "conf/$DOMAIN" "$NGINX_ROOT/sites-available/$DOMAIN"

  # Enable site
  sudo ln -sf "$NGINX_ROOT/sites-available/$DOMAIN" \
              "$NGINX_ROOT/sites-enabled/$DOMAIN"
done

# Validate and reload Nginx
sudo nginx -t
sudo systemctl reload nginx
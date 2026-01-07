# Host Multiple Websites (Virtual Hosts)
- Serve multiple domains from a single Nginx instance.
- Add SSL certificates for each domain using Let's Encrypt.

## Nginx Directory Structures

```conf
/var/www/
 ├── app.domain.com/
 └── web.domain.com/

/etc/nginx/
 ├── sites-available/
 │    ├── app.domain.com
 │    └── web.domain.com
 ├── sites-enabled/
 │    ├── app.domain.com -> ../sites-available/app.domain.com
 │    └── web.domain.com -> ../sites-available/web.domain.com
 └── snippets/
      └── common.conf
```

## STEP 1: Provision server and domains

1. **Provison an `Ubuntu` server**
2. **Setup `A records` in domain registry:**
   - `app.domain.com`-> `your_server_public_ip`
   - `web.domain.com`-> `your_server_public_ip`
   
>[!Warning]
> **Both records should have the same public IP.**

## STEP 2: Get project files in the server

1. **Clone code from github repo**
   
   ```sh
   git clone https://github.com/mirakib/nginx-real-world-projects.git
   ```
   
> [!Warning]
> **Before start deploying, replace domain name with yours.**

2. **Navigate to project directory:**

   ```sh
   cd nginx-real-world-projects/Project\ 07/
   ```

## STEP 3: Enable Nginx on the server

1. **Set permissions for all scripts:**
   
   ```sh
   chmod -R +x scripts/
   ```

2. **Install, Enable and Start Nginx:**
   
   ```
   sudo ./scripts/install_nginx.sh
   ````

## STEP 4: Setup Nginx for Multi-Domain Hosting

1. **Create domain directories in Nginx web root:**

   ```sh
   sudo mkdir -p /var/www/app.domain.com
   sudo mkdir -p /var/www/web.domain.com
   ```

2. **Place index files to /var/www/**

   ```sh
   sudo cp landing-pages/index.app.html /var/www/app.domain.com/index.html
   sudo cp landing-pages/index.web.html /var/www/web.domain.com/index.html
   ```
   
3. **Set Permission:**

   ```sh
   sudo chown -R $USER:www-data /var/www/app.domain.com
   sudo chown -R $USER:www-data /var/www/web.domain.com
   ```

4. **Create conf directories in Nginx conf root:**

   ```sh
   sudo mkdir -p "/etc/nginx/snippets"
   sudo mkdir -p "/etc/nginx/sites-available"
   sudo mkdir -p "/etc/nginx/sites-enabled"
   ```

5. **Place conf files to conf roots:**

   ```sh
   sudo cp conf/common.conf "/etc/nginx/snippets/common.conf"
   sudo cp conf/app.domain.com "/etc/nginx/sites-available/app.domain.com"
   sudo cp conf/web.domain.com "/etc/nginx/sites-available/web.domain.com"
   ```
   
## STEP 5: Enable Sites in Nginx for Web

1. **Create a symlink in sites-enabled**
   
   ```sh
   sudo ln -s /etc/nginx/sites-available/app.domain.com /etc/nginx/sites-enabled/
   sudo ln -s /etc/nginx/sites-available/web.domain.com /etc/nginx/sites-enabled/
   ```

2. **Reload Nginx:**

   ```sh
   sudo nginx -t
   sudo systemctl reload nginx
   ```

## STEP 6: Setup SSL with Let's Encrypt

1. **Run SSL Per Domain:**

   ```sh
   ./scripts/ssl_nginx.sh app.domain.com you@example.com
   ./scripts/ssl_nginx.sh web.domain.com you@example.com
   ```

2. **Reload Nginx:**

   ```sh
   sudo nginx -t
   sudo systemctl reload nginx
   ```
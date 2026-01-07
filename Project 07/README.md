# Host Multiple Websites (Virtual Hosts)**
- Serve multiple domains from a single Nginx instance.
- Add SSL certificates for each domain using Let's Encrypt.

## Nginx Directory Structures

```conf
/var/www/
 ├── app.mirakib.tech/
 └── web.mirakib.tech/

/etc/nginx/
 ├── sites-available/
 │    ├── app.mirakib.tech
 │    └── web.mirakib.tech
 ├── sites-enabled/
 │    ├── app.mirakib.tech -> ../sites-available/app.mirakib.tech
 │    └── web.mirakib.tech -> ../sites-available/web.mirakib.tech
 └── snippets/
      └── common.conf
```

## Git Clone the Repository

```sh
git clone https://github.com/mirakib/nginx-real-world-projects.git
```

```sh
cd nginx-real-world-projects/Project\ 07/
```

## Start and enable Nginx

**Set permissions and navigate to scripts directory:**
```sh
chmod -R +x scripts/
cd scripts/
```
**Run Install Script:**
```
sudo ./install_nginx.sh
````

## Place conf files at right places

**Set permission:**

```sh
sudo chown -R $USER:www-data /var/www/app.mirakib.tech
sudo chown -R $USER:www-data /var/www/web.mirakib.tech
```

## Enable Sites & Test

```sh
sudo ln -s /etc/nginx/sites-available/app.mirakib.tech /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/web.mirakib.tech /etc/nginx/sites-enabled/

sudo nginx -t
sudo systemctl reload nginx
```

## Setup SSL with Let's Encrypt

**Make it executable:**

```sh
chmod +x ssl_nginx.sh
```

**Run SSL Per Domain:**

```sh
./ssl_nginx.sh app.mirakib.tech you@example.com
./ssl_nginx.sh web.mirakib.tech you@example.com
```
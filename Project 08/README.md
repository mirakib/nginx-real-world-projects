# Rate Limiting & Security

- Configure rate limiting to prevent brute force attacks.


## Project structure

```
/var/www/app.domain.tech/
└── index.html
/etc/nginx/snippets/
└── rate-limit.conf
/etc/nginx/sites-available/
└── app.domain.tech
/etc/nginx/sites-enabled/
└── app.mirakib.tech -> /etc/nginx/sites-available/app.domain.tech
```

- `/var/www/app.mirakib.tech/index.html` → your website content
- `/etc/nginx/snippets/rate-limit.conf` → reusable rate limiting rules
- `/etc/nginx/sites-available/app.domain.tech` → Nginx server block
- `/etc/nginx/sites-enabled/app.domain.tech` → symlink to enable the site

## Step 1: Create the rate limiting snippet

`/etc/nginx/snippets/rate-limit.conf`

## Step 2: Update the main nginx.conf file

`sudo nano /etc/nginx/nginx.conf`

**Inside the http {} block, add this once:**

```
http {

    ##
    # Rate limiting zone (GLOBAL)
    ##
    limit_req_zone $binary_remote_addr zone=one:10m rate=10r/s;

    include /etc/nginx/sites-enabled/*;
}
```

**Disable default to avoid conflict:**

```sh
sudo rm /etc/nginx/sites-enabled/default
```

## Step 3: Create the Nginx server block

`/etc/nginx/sites-available/app.domain.tech`

## Step 4: Create landing page on Nginx web root

**Create folder as domain name on Nginx root:**

```sh
sudo mkdir -p /var/www/app.domain.tech
```

**Create a index.html page:**

```sh
sudo vi /var/www/app.domain.tech/index.html
```

## Step 5: Enable the site manually

```sh
sudo ln -s /etc/nginx/sites-available/app.domain.tech /etc/nginx/sites-enabled/app.domain.tech
```

## Step 6: Test and reload Nginx

```sh
sudo nginx -t
sudo systemctl reload nginx
```

## Step 6: Test rate limiting manually

**Run this from your laptop, not inside the VM:**

```sh
for i in {1..30}; do curl -s -o /dev/null -w "%{http_code}\n" http://app.domain.tech/; done
```

**Test with timing:**

```sh
ab -n 100 -c 20 http://app.domain.tech/
```

**Check Nginx logs:**

```sh
sudo tail -f /var/log/nginx/access.log
```
```sh
sudo tail -f /var/log/nginx/error.log
```


## Step 1: Place Files in Web Root 

By default, Ubuntu NGINX serves from: 

`/var/www/html`

You can replace or create your own site directory: 

`sudo mkdir -p /var/www/static-site`

`sudo cp -r * /var/www/static-site`

Ensure permissions: 

`sudo chown -R www-data:www-data /var/www/static-site`

## Step 2: Create a Virtual Host File 

sudo vi `/etc/nginx/sites-available/static-site`

```
server { 
  listen 80; 
  server_name skjptpp.in; 
  root /var/www/static-site; 
  index index.html;                           
  location / {   
    try_files $uri $uri/ =404; 
  } 
} 
```

## Step 3: Enable Site and Reload 

`sudo ln -s /etc/nginx/sites-available/static-site /etc/nginx/sites-enabled/ `

`sudo nginx -t `

`sudo systemctl reload nginx` 

Visit http://mywebsite.com (after DNS setup) — the static site is live! 

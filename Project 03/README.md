# Project-3 | Nginx As Load Balancer 

`sudo mkdir -p /var/www/frontend` 

`sudo cp -r frontend/* /var/www/frontend/` 

`sudo chown -R www-data:www-data /var/www/frontend`

`sudo vi /etc/nginx/sites-available/nginx-loadbalancer`

```
upstream backend_apis { 
  least_conn; 
  server 13.201.37.133:3001; 
  server 13.201.37.133:3002; 
  } 
server { 
  listen 80; 
  server_name skjptpp.in; 
  root /var/www/frontend; 
  index index.html; 
  # Serve frontend (HTML, CSS, JS, etc.) 
  location / { 
    try_files $uri $uri/ =404; 
  } 
  # Proxy API requests to backend Node.js apps 
  location /api/ { 
    proxy_pass http://backend_apis; 
    proxy_http_version 1.1; 
    proxy_set_header Host $host; 
    proxy_set_header X-Real-IP $remote_addr; 
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
  } 
}
```

## Goto Backend Folder --> Install Dependencies & start the Backend 

`cd /home/ubuntu/nginx-loadbalancer/` 

`cd backend1 && npm init -y && npm install express`    #in new Page 

`cd backend2 && npm init -y && npm install express`   #in new Page 

`node index.js` 

## Create Symbolic Link to Sites Enabled & Restart Nginx 

`sudo ln -s /etc/nginx/sites-available/nginx-loadbalancer /etc/nginx/sites-enabled/` 

`sudo nginx -t` 

`sudo systemctl reload nginx` 

## To simulate Traffic:

`sudo apt install apache2-utils` 

`ab -n 100 -c 10 http://skjptpp.in/api/`

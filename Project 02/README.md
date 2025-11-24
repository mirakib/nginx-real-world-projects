# Project-2 | Nginx As a Reverse Proxy 


`sudo mkdir -p /var/www/frontend`

`sudo cp -r frontend/* /var/www/frontend/` 

`sudo chown -R www-data:www-data /var/www/frontend`

`sudo vi /etc/nginx/sites-available/nginx-node-proxy`

```
server { 
  listen 80; 
  server_name skjptpp.in;  # Use _ or your IP if no domain yet 
  root /var/www/frontend; 
  index index.html; 
  # Serve static files 
  location / { 
    try_files $uri $uri/ =404; 
  } 
  # Reverse proxy to Node.js API 
  location /api/ { 
    proxy_pass http://13.201.37.133:3000; 
    proxy_http_version 1.1; 
    proxy_set_header Host $host; 
    proxy_set_header X-Real-IP $remote_addr; 
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
  } 
  # WebSocket support 
  location /socket.io/ { 
    proxy_pass http://localhost:3000; 
    proxy_http_version 1.1; 
    proxy_set_header Upgrade $http_upgrade; 
    proxy_set_header Connection "upgrade"; 
    proxy_set_header Host $host; 
  } 
} 
```

## Goto Backend Folder --> Install Dependencies & start the Backend 

`cd /home/ubuntu/nginx-node-proxy/backend`

`npm init -y`

`npm install express cors socket.io`

`node index.js` 

## Create Symbolic Link to Sites Enabled & Restart Nginx 

`sudo ln -s /etc/nginx/sites-available/nginx-node-proxy /etc/nginx/sites-enabled/` 

`sudo nginx -t` 

`sudo systemctl reload nginx`
 
## Access on Your Domain like example.com

# Nginx Real World Projects For Beginners

- Project-1 | Serving Static Website Using Nginx 
- Project-2 | Nginx As a Reverse Proxy 
- Project-3 | Nginx As Load Balancer
- Project-4 | Nginx AS Web Server on EC2 Instance
- Project-5 | Nginx Setup using Terraform on AWS
- Project-6 | SSL Automation for Nginx
- Project-7 | Host Multiple Websites
- Project-8 | Rate Limiting & Security
- Project-9 | Dockerized Nginx with SSL
  
Nginx installation: `sudo apt install nginx -y`

### Nginx Main Config File Locations (Ubuntu/Debian-based systems):

```
/etc/nginx/
│
├── nginx.conf                → Main configuration file
│
├── conf.d/                   → Extra configuration snippets (global)
│   ├── proxy.conf
│   ├── gzip.conf
│
├── sites-available/          → Available server blocks (virtual hosts)
│   ├── default
│   ├── example.com.conf
│
├── sites-enabled/            → Active server blocks (symlinks)
│   ├── example.com.conf → 
│
└── snippets/                 → Reusable small configuration parts
    ├── ssl.conf
    ├── fastcgi-php.conf

```


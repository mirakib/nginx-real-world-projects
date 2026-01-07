server {
    listen 80;
    server_name app.domain.com;

    root /var/www/app.domain.com/;

    include snippets/common.conf;
}

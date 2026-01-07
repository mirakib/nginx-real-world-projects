server {
    listen 80;
    server_name web.domain.com;

    root /var/www/web.domain.com/;

    include snippets/common.conf;
}

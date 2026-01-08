FROM nginx:1.25-alpine

RUN addgroup -S nginxgrp && adduser -S nginxusr -G nginxgrp \
&& apk add --no-cache bash curl openssl inotify-tools

RUN mkdir -p /etc/nginx/conf.d /var/cache/nginx /var/run \
&& chown -R nginxusr:nginxgrp /etc/nginx /var/cache/nginx /var/run

USER nginxusr

CMD ["/bin/sh", "-c", "nginx -g 'daemon off;' & while inotifywait -e modify,create,delete /etc/nginx/conf.d; do nginx -s reload; done"]
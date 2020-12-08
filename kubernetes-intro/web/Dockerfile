FROM alpine:3.12.1

ENV USER=nginx
ENV UID=1001
ENV GID=1001

RUN apk update && \
    apk add --no-cache shadow nginx && \
    usermod -u $UID nginx && groupmod -g $GID nginx && \
    mkdir -p /run/nginx

RUN echo 'server { listen 8000 default_server; location / { root /var/www/localhost/htdocs/; } }' > /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off; error_log /dev/stdout debug;"]    


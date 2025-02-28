FROM alpine:3.18

RUN apk add --no-cache nginx && \
    mkdir -p /tmp/nginx && \
    chown -R nginx:nginx /tmp/nginx && \
    mkdir -p /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx/html

COPY config/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /tmp && \
    chown -R nginx:nginx /tmp && \
    chmod -R 755 /tmp && \
    chown -R nginx:nginx /var/lib/nginx && \
    chmod -R 755 /var/lib/nginx

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"] 
FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add nginx openssl openssh supervisor\
    telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

RUN adduser -D turn
RUN echo "root:qwerty" | chpasswd

RUN mkdir -p /run/nginx
COPY ./telegraf.conf /etc/telegraf/
COPY ./nginx-localhost /etc/nginx/conf.d/default.conf
COPY ./supervisor.conf /etc/supervisord.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt  -subj "/C=RU/ST=Kazan/L=Kazan/O=21/OU=hguini/CN=localhost"

COPY ./start_nginx.sh .
EXPOSE 80 443
RUN chmod +x start_nginx.sh
ENTRYPOINT sh start_nginx.sh
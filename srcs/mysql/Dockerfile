FROM alpine:3.12

RUN apk update; \
	apk add --no-cache mysql mysql-client vim

RUN apk add --no-cache telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    mkdir -p /etc/telegraf
COPY ../influxdb/srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY start.sh /
COPY wordpress.sql /

EXPOSE 3306

CMD ./start.sh
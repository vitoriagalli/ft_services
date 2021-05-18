FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
    influxdb

COPY srcs/ /

RUN apk add --no-cache telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

CMD ["sh", "start.sh"]
FROM alpine:3.12

RUN apk update; \
	apk add --no-cache influxdb \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ ./

RUN mkdir -p /etc/telegraf; \
    mv telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

CMD ["sh", "start.sh"]
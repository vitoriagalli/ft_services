FROM alpine:3.12

RUN apk update; \
	apk add --no-cache influxdb vim;

COPY srcs/ /

RUN mkdir -p /etc/telegraf; \
    mv telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

CMD ["sh", "start.sh"]
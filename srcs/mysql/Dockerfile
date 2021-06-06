FROM alpine:3.12

RUN apk update; \
	apk add --no-cache mysql mysql-client vim \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ ./

RUN mkdir -p /etc/telegraf; \
    mv telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 3306

ENTRYPOINT ["sh", "start.sh"]

FROM alpine:3.12

RUN apk update; \
	apk add --no-cache mysql mysql-client vim

COPY start.sh /
COPY wordpress.sql /

EXPOSE 3306

CMD ./start.sh
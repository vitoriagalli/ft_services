FROM alpine:3.12

RUN apk update; \
	apk add --no-cache mysql mysql-client

# COPY start.sh /
# COPY wordpress.sql /

COPY /* /

EXPOSE 3306

CMD ./start.sh
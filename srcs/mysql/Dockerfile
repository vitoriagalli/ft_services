FROM alpine:3.12

RUN apk update; \
	apk add --no-cache mysql mysql-client

RUN mkdir -p /run/mysqld

# COPY ./my.cnf /etc/mysql/my.cnf

COPY ./* /

EXPOSE 3306

CMD ./init.sh
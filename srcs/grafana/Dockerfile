FROM alpine:3.12

RUN apk update; \
    apk add --no-cache libc6-compat wget vim && \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    wget https://dl.grafana.com/oss/release/grafana-7.5.6.linux-amd64.tar.gz && \
    tar -zxvf grafana-7.5.6.linux-amd64.tar.gz && \
    rm -rf grafana-7.5.6.linux-amd64.tar.gz

COPY srcs/ ./

RUN mkdir -p /etc/telegraf; \
    mv telegraf.conf /etc/telegraf/telegraf.conf

ENV PATH=/grafana-7.5.6/bin:$PATH

EXPOSE 3000

CMD ["sh", "start.sh"]
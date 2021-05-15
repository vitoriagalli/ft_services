FROM alpine:3.12

ENV PATH=/grafana-7.5.6/bin:$PATH

RUN apk update; \
	apk add --no-cache wget vim && \
    wget https://dl.grafana.com/oss/release/grafana-7.5.6.linux-amd64.tar.gz && \
    tar -zxvf grafana-7.5.6.linux-amd64.tar.gz && \
    rm -rf grafana-7.5.6.linux-amd64.tar.gz && \
    mkdir -p /var/lib/grafana/dashboards

COPY srcs/ /

RUN mkdir -p /etc/telegraf; \
    mv telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 3000

# ENTRYPOINT ["grafana-server"]
CMD ["sh", "start.sh"]

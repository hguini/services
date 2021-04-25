FROM alpine:3.12

RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update
RUN apk upgrade
RUN apk add sudo openrc vim wget supervisor telegraf grafana

RUN openrc
RUN touch /run/openrc/softlevel


COPY ./supervisor.conf /etc/supervisord.conf
COPY ./datasource.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY ./dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY ./telegraf.conf /etc/
COPY ./default.json /usr/share/grafana/public/dashboards/
COPY ./start.sh .
RUN chmod +x start.sh

EXPOSE 3000

CMD sh start.sh
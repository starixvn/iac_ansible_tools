#FROM haproxy:latest
FROM haproxytech/haproxy-debian:2.4.2
MAINTAINER NexOps
USER root
RUN apt-get update && apt-get install rsyslog -y
ADD haproxy.conf /etc/rsyslog.d/haproxy.conf
ADD rsyslog.conf /etc/rsyslog.conf
ADD haproxy /etc/logrotate.d/haproxy

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

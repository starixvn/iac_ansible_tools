FROM prom/prometheus
#:v2.5.0
# https://hub.docker.com/r/prom/prometheus/tags/

ENV WEAVE_TOKEN=none

COPY conf /etc/prometheus/
USER root
# RUN chmod +x /etc/prometheus/docker-entrypoint.sh
# ENTRYPOINT [ "/etc/prometheus/docker-entrypoint.sh" ]
CMD [ "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus" ]
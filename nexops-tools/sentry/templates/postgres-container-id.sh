#!/usr/bin/env bash
docker inspect $(docker service ps -q --filter desired-state=running sentry_postgres_lumi) --format "{{ .Status.ContainerStatus.ContainerID }}"
#docker ps -aqf "name=^sentry_cron_lumi"
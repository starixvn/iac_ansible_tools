#!/usr/bin/env bash
docker inspect $( docker service ps -q --filter desired-state=running sentry_postgres_org ) --format "{{ .Status.ContainerStatus.ContainerID }}"
#!/usr/bin/env bash
docker inspect $(docker service ps -q --filter desired-state=running sentry_web_org) --format "{{ .Status.ContainerStatus.ContainerID }}"
#!/usr/bin/env bash

docker-compose -f docker-compose-no-ssl-proxy.yaml down
docker-compose --env-file .env.dev -f docker-compose-no-ssl-services.yaml down

#!/usr/bin/env sh

docker-compose -f docker-compose-no-ssl-proxy.yaml up -d
docker-compose --env-file .env.dev -f docker-compose-no-ssl-services.yaml up -d

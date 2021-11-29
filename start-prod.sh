#!/usr/bin/env sh

docker-compose --env-file .env.dev -f docker-compose-ssl-proxy.yaml up -d
#docker-compose --env-file .env.dev -f docker-compose-ssl-services.yaml up -d

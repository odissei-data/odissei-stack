#!/usr/bin/env sh

docker-compose --env-file .env.prod -f docker-compose-ssl-proxy.yaml up -d
docker-compose --env-file .env.prod -f docker-compose-ssl-service.yaml up -d

#!/usr/bin/env bash

docker-compose --env-file .env.prod -f docker-compose-ssl-proxy.yaml down
#docker-compose --env-file .env.prod -f docker-compose-ssl-services.yaml down

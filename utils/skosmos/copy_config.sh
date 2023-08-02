#!/usr/bin/env sh
#
# Takes care to substitute the Skosmos file in place.

cp ../../distros/Skosmos/dockerfiles/config/config-docker-compose.ttl ../../distros/Skosmos/dockerfiles/config/config-docker-compose-backup.ttl
cp ../../distros/Skosmos/dockerfiles/docker-compose.yml ../../distros/Skosmos/dockerfiles/docker-compose-backup.yml

cp docker-compose-skosmos.ttl ../../distros/Skosmos/dockerfiles/config/config-docker-compose.ttl
cp docker-compose.yml ../../distros/Skosmos/dockerfiles/docker-compose.yml
docker exec -it restart skosmos

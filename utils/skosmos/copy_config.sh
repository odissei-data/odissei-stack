#!/usr/bin/env sh
#
# Takes care to substitute the Skosmos file in place.

cp ../../distros/Skosmos/dockerfiles/config/config-docker-compose.ttl ../../distros/Skosmos/dockerfiles/config/config-docker-compose-backup.ttl
cp docker-compose-skosmos.ttl ../../distros/Skosmos/dockerfiles/config/config-docker-compose.ttl

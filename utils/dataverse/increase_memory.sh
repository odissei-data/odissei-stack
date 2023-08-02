#!/usr/bin/env sh

# Small script to increase memory footprint for a dataverse.

sed -I '' "s/JVM_OPTS='-Xmx1g -Xms1g -XX:MaxPermSize=2g -XX:PermSize=2g'/JVM_OPTS='-Xmx4g -Xms2g -XX:MaxPermSize=2g -XX:PermSize=2g'/g" ../../distros/vanilla/docker-compose.yml
docker restart dataverse

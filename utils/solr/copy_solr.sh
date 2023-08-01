#!/usr/bin/env sh
#
# This file takes care to copy the solr config to the correct location and rebooting the container.

cp schema.xml ../../config/schema.xml
cp schema.xml ../../distros/vanilla/config/schema.xml
docker restart solr

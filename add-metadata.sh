#!/bin/bash
docker exec -it dataverse chmod +x /opt/payara/init.d/1002-custom-metadata.sh
docker exec -it dataverse bash /opt/payara/init.d/1002-custom-metadata.sh

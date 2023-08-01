!#bin/bash

# Be sure to invoke this script from the exact directory it's mounted in. Otherwise - expect side effects.
CURRENT_PATH=$(pwd)

docker cp upload-blocks.sh dataverse:/tmp/
docker cp upload-variable.sh dataverse:/tmp/
cd ../Custom-Metadata-Blocks/tsv_files
docker cp . dataverse:/tmp/
docker exec -it dataverse chmod +x /tmp/upload-variable.sh
docker exec -it dataverse sh /tmp/upload-variable.sh
cd $CURRENT_PATH

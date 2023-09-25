!#bin/bash

# Be sure to invoke this script from the exact directory it's mounted in. Otherwise - expect side effects.
CURRENT_PATH=$(pwd)

docker cp upload-blocks.sh dataverse:/tmp/
cd ../Custom-Metadata-Blocks/tsv_files
docker cp . dataverse:/tmp/
docker exec -it dataverse chmod +x /tmp/upload-blocks.sh
docker exec -it dataverse sh /tmp/upload-blocks.sh
cd $CURRENT_PATH

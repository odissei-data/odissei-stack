#!/bin/bash

# Running python script to invoke webhooks
if [ "${CLARIN}" ]; then
    wget https://raw.githubusercontent.com/IQSS/dataverse-docker/master/config/schemas/cmdi-oral-history.tsv -O /tmp/cmdi.tsv
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/cmdi.tsv
    custommetadatablock=True
fi

if [ "${CESSDA}" ]; then
    wget https://gdcc.github.io/dataverse-external-vocab-support/scripts/skosmos.js -O /tmp/skosmos.js
#    wget https://raw.githubusercontent.com/ekoi/speeltuin/master/resources/CMM_Custom_MetadataBlock.tsv -O /tmp/CMM_Custom_MetadataBlock.tsv
    wget https://raw.githubusercontent.com/IQSS/dataverse-docker/master/config/schemas/CESSDA_CMM.tsv -O /tmp/CMM_Custom_MetadataBlock.tsv
    wget https://raw.githubusercontent.com/IQSS/dataverse-docker/master/config/schemas/cv_voc.json -O /tmp/cv_voc.json
    curl -H "Content-Type: application/json" -X PUT \
          -d @/tmp/cv_voc.json http://localhost:8080/api/admin/settings/:CVocConf
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/CMM_Custom_MetadataBlock.tsv
    custommetadatablock=True
fi

if [ "${ODISSEI}" ]; then
    wget https://cdn.jsdelivr.net/gh/SSHOC/dataverse-external-vocab-support/scripts/skosmos-no-lang.js -O /tmp/skosmos.js
    wget https://raw.githubusercontent.com/SSHOC/dataverse-external-vocab-support/main/examples/config/cv_odissei.json -O /tmp/cv_voc.json
    curl -H "Content-Type: application/json" -X PUT \
          -d @/tmp/cv_voc.json http://localhost:8080/api/admin/settings/:CVocConf
    custommetadatablock=True
    # Retrieve CBS metadata block and add
    wget https://raw.githubusercontent.com/odissei-data/Custom-Metadata-Blocks/main/tsv%20files/CBSMetadata.tsv -O /tmp/cbs-metadata.tsv
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/cbs-metadata.tsv
    # Retrieve enrichments block and add
    wget https://raw.githubusercontent.com/odissei-data/Custom-Metadata-Blocks/main/tsv%20files/enrichments.tsv -O /tmp/enrichments.tsv
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/enrichments.tsv
    # Retrieve question/information block and add
    wget https://raw.githubusercontent.com/odissei-data/Custom-Metadata-Blocks/main/tsv%20files/questionInformation.tsv -O /tmp/questionanswer.tsv
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/questionanswer.tsv
    # Retrieve provenance block and add
    wget https://raw.githubusercontent.com/odissei-data/Custom-Metadata-Blocks/main/tsv%20files/provenance.tsv -O /tmp/provenance.tsv
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/provenance.tsv
    # Retrieve variable information block and add
    wget https://raw.githubusercontent.com/odissei-data/Custom-Metadata-Blocks/main/tsv%20files/variableInformation.tsv -O /tmp/variable.tsv
    curl http://localhost:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file /tmp/variable.tsv
fi

if  [ -n "$custommetadatablock" ]; then
    wget https://github.com/IQSS/dataverse/releases/download/v5.8/update-fields.sh -O /tmp/update-fields.sh
    cd /tmp
    chmod +x update-fields.sh
    /bin/cp ${HOME_DIR}/dvinstall/schema.xml /tmp/schema.xml
    curl "http://localhost:8080/api/admin/index/solr/schema" | ./update-fields.sh schema.xml
    /bin/cp /tmp/schema.xml ${HOME_DIR}/dvinstall/schema.xml
    wget https://github.com/IQSS/dataverse/releases/download/v5.1/updateSchemaMDB.sh -O /tmp/updateSchemaMDB.sh
    chmod +x updateSchemaMDB.sh
    ./updateSchemaMDB.sh -s solr:8983
fi

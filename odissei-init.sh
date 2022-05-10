#!/bin/bash

#cp .env_sample .env
curl -L -o stw.ttl.zip http://zbw.eu/stw/version/latest/download/stw.ttl.zip
unzip -o stw.ttl.zip
curl -I -X POST -H Content-Type:text/turtle -T stw.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=http://zbw.eu/stw/
curl -L -o unescothes.ttl http://skos.um.es/unescothes/unescothes.ttl
curl -I -X POST -H Content-Type:text/turtle -T unescothes.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=http://skos.um.es/unescothes/

# wget from github and store CBS vocabulary in ./config/cbs-variables-thesaurus.ttl
curl -I -X POST -H Content-Type:text/turtle -T ./config/cbs-variables-thesaurus.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=http://cbs.nl/variables/

# ellst
curl -X 'GET' 'https://thesauri.cessda.eu/rest/v1/elsst/data?format=text/turtle' > ELSST.ttl
curl -I -X POST -H Content-Type:text/turtle -T ELSST.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=http://thesauri.cessda.eu/elsst/

# cessda topic classification
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/TopicClassification/4.0?languageVersion=en-4.0_de-4.0.1_it-4.0.1_fr-4.0.1_nl-4.2.1' \
     -H 'accept: application/xml' > TopicClassification.rdf
rapper TopicClassification.rdf --output turtle > TopicClassification.ttl
curl -I -X POST -H Content-Type:text/rdf -T TopicClassification.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/TopicClassification

curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/GeneralDataFormat/2.0?languageVersion=en-2.0_de-2.0_fr-2.0.1_it-2.0.1_nl-2.0.1' \
     -H 'accept: application/xml' > GeneralDataFormat.rdf
rapper GeneralDataFormat.rdf --output turtle > GeneralDataFormat.ttl
curl -I -X POST -H Content-Type:text/rdf -T GeneralDataFormat.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/GeneralDataFormat

# Analysis unit
curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/AnalysisUnit/2.0?languageVersion=en-2.0_de-2.0.1_fr-2.0.1_it-2.1.1_nl-2.1.1' \
     -H 'accept: application/xml' > AnalysisUnit.rdf
rapper AnalysisUnit.rdf --output turtle > AnalysisUnit.ttl
curl -I -X POST -H Content-Type:text/rdf -T AnalysisUnit.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/AnalysisUnit

# Time method

curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/TimeMethod/2.0?languageVersion=en-1.2_de-1.2.1_fr-1.2.1_nl-1.2.1_it-1.2.1' \
     -H 'accept: application/xml' > TimeMethod.rdf
rapper TimeMethod.rdf --output turtle > TimeMethod.ttl
curl -I -X POST -H Content-Type:text/rdf -T TimeMethod.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/TimeMethod

# Sampling Procedure
curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/SamplingProcedure/2.0?languageVersion=en-1.1_de-1.1.1_fr-1.1.3_it-1.1.1_nl-1.1.1' \
     -H 'accept: application/xml' > SamplingProcedure.rdf
rapper SamplingProcedure.rdf --output turtle > SamplingProcedure.ttl
curl -I -X POST -H Content-Type:text/rdf -T SamplingProcedure.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/SamplingProcedure

# Type of Instrument
curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/TypeOfInstrument/2.0?languageVersion=en-1.1_nl-1.1.1_de-1.1.1_fr-1.1.1_it-1.1.1' \
     -H 'accept: application/xml' > TypeOfInstrument.rdf
rapper TypeOfInstrument.rdf --output turtle > TypeOfInstrument.ttl
curl -I -X POST -H Content-Type:text/rdf -T TypeOfInstrument.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/TypeOfInstrument

# Data Source Type
curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/DataSourceType/2.0?languageVersion=en-1.0_de-1.0.1_nl-1.0.1_fr-1.0.1_it-1.0.1' \
     -H 'accept: application/xml' > DataSourceType.rdf
rapper DataSourceType.rdf --output turtle > DataSourceType.ttl
curl -I -X POST -H Content-Type:text/rdf -T DataSourceType.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/DataSourceType

 # Summary statistics
curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/SummaryStatistics/2.0?languageVersion=en-2.1-nl-2.1.1_de-2.1.1_fr-2.1.1_it-2.1.1' \
     -H 'accept: application/xml' > SummaryStatistics.rdf
rapper SummaryStatistics.rdf --output turtle > SummaryStatistics.ttl
curl -I -X POST -H Content-Type:text/rdf -T SummaryStatistics.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/SummaryStatistics

# Mode of Collection
curl -X 'GET' \
     'http://vocabularies.cessda.eu/v2/vocabularies/ModeOfCollection/2.0?languageVersion=en-4.0_nl-4.0.1_de-4.0.1_fr-4.0.1_it-4.0.1' \
     -H 'accept: application/xml' > ModeOfCollection.rdf
rapper ModeOfCollection.rdf --output turtle > ModeOfCollection.ttl
curl -I -X POST -H Content-Type:text/rdf -T ModeOfCollection.ttl -G http://0.0.0.0:3030/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/ModeOfCollection

echo "Checking search index..."
curl "http://0.0.0.0:8000/rest/v1/search?vocab=stw&query=a*"

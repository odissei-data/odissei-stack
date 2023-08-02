#!/usr/bin/env sh
# Basic parameters on where to deposit and auth credentials.
# The authheader is base64 encoded with format "username:password"
# The target url is preferred for depositing and for checking the instance.

#FUSEKI_URL=""
#SKOSMOS_TARGET=""

TARGET="${FUSEKI_URL:-localhost:9030}"
SKOSMOS_TARGET="${SKOSMOS_TARGET:-localhost:9090}"
AUTHHEADER="YWRtaW46YWRtaW4="

# The urls to be downloaded. This can be used for versioning.
STW_URL='http://zbw.eu/stw/version/latest/download/stw.ttl.zip'
UNESCO_URL='http://skos.um.es/unescothes/unescothes.ttl'
ELSST_URL='https://thesauri.cessda.eu/rest/v1/elsst-3/data?format=text/turtle'
CBS_URL='https://raw.githubusercontent.com/odissei-data/vocabularies/main/cbs/cbs-variables-thesaurus-20230310.ttl'
TOPIC_CLASSIFICATION_URL='https://vocabularies.cessda.eu/v2/vocabularies/TopicClassification/4.2.2?languageVersion=en-4.2.2_nl-4.2.2'
GENERAL_DATA_FORMAT_URL='https://vocabularies.cessda.eu/v2/vocabularies/GeneralDataFormat/2.0.3?languageVersion=en-2.0.3_nl-2.0.3'
ANALYSIS_UNIT_URL='https://vocabularies.cessda.eu/v2/vocabularies/AnalysisUnit/2.1.3?languageVersion=en-2.1.3_nl-2.1.3'
TIME_METHOD_URL='https://vocabularies.cessda.eu/v2/vocabularies/TimeMethod/1.2.3?languageVersion=en-1.2_nl-1.2.3'
SAMPLING_PROCEDURE_URL='https://vocabularies.cessda.eu/v2/vocabularies/SamplingProcedure/1.1.4?languageVersion=en-1.1.4_nl-1.1.4'
TYPE_OF_INSTRUMENT_URL='https://vocabularies.cessda.eu/v2/vocabularies/TypeOfInstrument/1.1.2?languageVersion=en-1.1.4_nl-1.1.2'
DATA_SOURCE_TYPE_URL='https://vocabularies.cessda.eu/v2/vocabularies/DataSourceType/1.0.2?languageVersion=en-1.0.2_nl-1.0.2'
SUMMARY_STATISTICS_URL='https://vocabularies.cessda.eu/v2/vocabularies/SummaryStatisticType/2.1.2?languageVersion=en-2.1.2_nl-2.1.2'
MODE_OF_COLLECTION_URL='https://vocabularies.cessda.eu/v2/vocabularies/ModeOfCollection/4.0.3?languageVersion=en-4.0.3_nl-4.0.3'

MCAL_RESEARCHTYPEQUESTION_URL='https://raw.githubusercontent.com/odissei-data/vocabularies/main/mcal/ResearchQuestionType.ttl'
MCAL_CONTENTTYPEANALYSIS_URL='https://raw.githubusercontent.com/odissei-data/vocabularies/main/mcal/ContentAnalysisType.ttl'
MCAL_CONTENTFEATURES_URL='https://raw.githubusercontent.com/odissei-data/vocabularies/main/mcal/ContentFeature.ttl'

# The endpoints where the created triples should be deposited. This is required for
# Skosmos to connect to.
# Don't use encapsulating quotation marks here.
STW_GRAPH_ENDPOINT=http://zbw.eu/stw/
UNESCO_GRAPH_ENDPOINT=http://skos.um.es/unescothes/
ELSST_GRAPH_ENDPOINT=https://thesauri.cessda.eu/elsst/
CBS_GRAPH_ENDPOINT=http://cbs.nl/variables/
TOPIC_CLASSIFICATION_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/TopicClassification
GENERAL_DATA_FORMAT_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/GeneralDataFormat
ANALYSIS_UNIT_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/GeneralDataFormat
TIME_METHOD_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/TimeMethod
SAMPLING_PROCEDURE_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/SamplingProcedure
TYPE_OF_INSTRUMENT_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/TypeOfInstrument
DATA_SOURCE_TYPE_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/DataSourceType
SUMMARY_STATISTICS_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/SummaryStatistics
MODE_OF_COLLECTION_GRAPH_ENDPOINT=https://vocabularies.cessda.eu/vocabulary/ModeOfCollection

MCAL_RESEARCHTYPEQUESTION_GRAPH_ENDPOINT='https://odissei-data/mcal/researchtypequestion'
MCAL_CONTENTTYPEANALYSIS_GRAPH_ENDPOINT='https://odissei-data/mcal/contenttypeanalysis'
MCAL_CONTENTFEATURES_GRAPH_ENDPOINT='https://odissei-data/mcal/contentfeatures'

# Fair warning; you might see some errors with the rapper parsing. This shouldn't be breaking,
# but can be verified by checking the output of the curl into the Fuseki instance.

# STW; this is a bit different since it's a zip
echo "Getting STW"
curl -L -o stw.ttl.zip $STW_URL
unzip -o stw.ttl.zip
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @stw.ttl \
 $TARGET/skosmos/data?graph=$STW_GRAPH_ENDPOINT

# UNESCO
echo "Getting UNESCO"
curl -L -o unescothes.ttl $UNESCO_URL
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @unescothes.ttl \
 $TARGET/skosmos/data?graph=$UNESCO_GRAPH_ENDPOINT

# ELSST
echo "Getting ELSST"
curl -L -o elsst.ttl $ELSST_URL
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @elsst.ttl \
 $TARGET/skosmos/data?graph=$ELSST_GRAPH_ENDPOINT

# CBS
echo "Getting CBS"
curl -L -o cbs.ttl $CBS_URL
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @cbs.ttl \
 $TARGET/skosmos/data?graph=$CBS_GRAPH_ENDPOINT

# Topic classification
echo "Getting topic classification"
curl $ANALYSIS_UNIT_URL -H 'accept: application/xml' -o TopicClassification.rdf
rapper TopicClassification.rdf --output turtle > TopicClassification.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @TopicClassification.ttl \
 $TARGET/skosmos/data?graph=$TOPIC_CLASSIFICATION_GRAPH_ENDPOINT

#General data format
echo "Getting general data format"
curl $GENERAL_DATA_FORMAT_URL -H 'accept: application/xml' -o GeneralDataFormat.rdf
rapper GeneralDataFormat.rdf --output turtle > GeneralDataFormat.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @GeneralDataFormat.ttl \
 $TARGET/skosmos/data?graph=$GENERAL_DATA_FORMAT_GRAPH_ENDPOINT

# Analysis unit
echo "Getting analysis unit vocab"
curl $ANALYSIS_UNIT_URL -H 'accept: application/xml' -o AnalysisUnit.rdf
rapper AnalysisUnit.rdf --output turtle > AnalysisUnit.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @AnalysisUnit.ttl \
 $TARGET/skosmos/data?graph=$ANALYSIS_UNIT_GRAPH_ENDPOINT

# Time method
echo 'Getting time method vocab'
curl $TIME_METHOD_URL -H 'accept: application/xml' -o TimeMethod.rdf
rapper TimeMethod.rdf --output turtle > TimeMethod.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @TimeMethod.ttl \
 $TARGET/skosmos/data?graph=$TIME_METHOD_GRAPH_ENDPOINT

#Sampling procedure
echo 'Getting sampling procedure vocab'
curl $SAMPLING_PROCEDURE_URL -H 'accept: application/xml' -o SamplingProcedure.rdf
rapper SamplingProcedure.rdf --output turtle > SamplingProcedure.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @SamplingProcedure.ttl \
 $TARGET/skosmos/data?graph=$SAMPLING_PROCEDURE_GRAPH_ENDPOINT

# Type of instrument
echo 'Getting type of instrument vocab'
curl $TYPE_OF_INSTRUMENT_URL -H 'accept: application/xml' -o TypeOfInstrument.rdf
rapper TypeOfInstrument.rdf --output turtle > TypeOfInstrument.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @TypeOfInstrument.ttl \
 $TARGET/skosmos/data?graph=$TYPE_OF_INSTRUMENT_GRAPH_ENDPOINT

# Data source type
echo 'Getting data source type vocab'
curl $DATA_SOURCE_TYPE_URL -H 'accept: application/xml' -o DataSourceType.rdf
rapper DataSourceType.rdf --output turtle > DataSourceType.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @DataSourceType.ttl \
 $TARGET/skosmos/data?graph=$DATA_SOURCE_TYPE_GRAPH_ENDPOINT

# Summary statistics
echo 'Getting summary statistics vocab'
curl $SUMMARY_STATISTICS_URL -H 'accept: application/xml' -o SummaryStatistics.rdf
rapper SummaryStatistics.rdf --output turtle > SummaryStatistics.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @SummaryStatistics.ttl \
 $TARGET/skosmos/data?graph=$SUMMARY_STATISTICS_GRAPH_ENDPOINT

# Mode of collection
echo 'Getting mode of collection vocab'
curl $MODE_OF_COLLECTION_URL -H 'accept: application/xml' -o ModeOfCollection.rdf
rapper ModeOfCollection.rdf --output turtle > ModeOfCollection.ttl
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @ModeOfCollection.ttl \
 $TARGET/skosmos/data?graph=$MODE_OF_COLLECTION_GRAPH_ENDPOINT

# Mcal research type question
echo "Mcal research type question"
curl -l -o ResearchTypeQuestion.ttl $MCAL_RESEARCH_TYPE_QUESTION_URL
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @ModeOfCollection.ttl \
 $TARGET/skosmos/data?graph=$MCAL_RESEARCH_TYPE_QUESTION_URL

# Mcal content analysis type
echo "Mcal content analysis type"
curl -l -o ContentAnalysisType.ttl $MCAL_CONTENT_ANALYSIS_TYPE_URL
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @ContentAnalysisType.ttl \
 $TARGET/skosmos/data?graph=$MCAL_CONTENT_ANALYSIS_TYPE_GRAPH_ENDPOINT

# Mcal content features
echo "Mcal content features"
curl -l -o ContentFeatures.ttl $MCAL_CONTENT_FEATURES_URL
curl -X POST \
 -H "Content-Type: text/turtle" \
 -H "Authorization: Basic $AUTHHEADER" \
 --data-binary @ContentFeatures.ttl \
 $TARGET/skosmos/data?graph=$MCAL_CONTENT_FEATURES_GRAPH_ENDPOINT



# And a check..
echo "Checking search index..."
# curl "${SKOSMOS_TARGET}/rest/v1/search?vocab=stw&query=a*"

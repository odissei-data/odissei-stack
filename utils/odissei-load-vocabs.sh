#!/bin/bash

#cp .env_sample .env

# wget from github and store CBS vocabulary in ./config/cbs-variables-thesaurus.ttl
echo "ODISSEI CBS Variable thesaurus"
curl -l -o cbs-variables-thesaurus.ttl https://raw.githubusercontent.com/odissei-data/vocabularies/main/cbs/cbs-variables-thesaurus-20230310.ttl
curl -I -X POST -H Content-Type:text/turtle -T cbs-variables-thesaurus.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=http://cbs.nl/variables/
rm cbs-variables-thesaurus.ttl

exit

echo "ODISSEI MCAL Vocabularies: ContentAnalysisType"
curl -l -o ContentAnalysisType.ttl https://raw.githubusercontent.com/odissei-data/vocabularies/main/mcal/ContentAnalysisType.ttl
curl -I -X POST -H Content-Type:text/turtle -T ContentAnalysisType.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://mcal.odissei.nl/cv/contentAnalysisType/v0.1/
rm ContentAnalysisType.ttl

echo "ODISSEI MCAL Vocabularies: ResearchQuestionType"
curl -l -o ResearchQuestionType.ttl https://raw.githubusercontent.com/odissei-data/vocabularies/main/mcal/ResearchQuestionType.ttl
curl -I -X POST -H Content-Type:text/turtle -T ResearchQuestionType.ttl  -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://mcal.odissei.nl/cv/researchQuestionType/v0.1/
rm ResearchQuestionType.ttl

echo "STW Thesaurus"
curl -L -o stw.ttl.zip http://zbw.eu/stw/version/latest/download/stw.ttl.zip
unzip -o stw.ttl.zip
curl -I -X POST -H Content-Type:text/turtle -T stw.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=http://zbw.eu/stw/
rm stw.ttl*

echo "UNESCO Thesaurus"
curl -L -o unescothes.ttl http://skos.um.es/unescothes/unescothes.ttl
curl -I -X POST -H Content-Type:text/turtle -T unescothes.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=http://skos.um.es/unescothes/
rm unescothes.ttl


# ellst
echo "getting ELLST vocab"
wget 'https://thesauri.cessda.eu/rest/v1/elsst-3/data?format=text/turtle' --output-document=ELSST.ttl 
curl -I -X POST -H Content-Type:text/turtle -T ELSST.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://thesauri.cessda.eu/elsst/

# cessda topic classification
echo "getting topic classification"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/TopicClassification/4.0?languageVersion=en-4.0_de-4.0.1_it-4.0.1_fr-4.0.1_nl-4.2.1' \
     -H 'accept: application/xml' > TopicClassification.rdf
rapper TopicClassification.rdf --output turtle > TopicClassification.ttl
curl -I -X POST -H Content-Type:text/turtle -T TopicClassification.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/TopicClassification

echo "getting general data format"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/GeneralDataFormat/2.0?languageVersion=en-2.0_de-2.0_fr-2.0.1_it-2.0.1_nl-2.0.1' \
     -H 'accept: application/xml' > GeneralDataFormat.rdf
rapper GeneralDataFormat.rdf --output turtle > GeneralDataFormat.ttl
curl -I -X POST -H Content-Type:text/turtle -T GeneralDataFormat.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/GeneralDataFormat

# Analysis unit
echo "Getting analysis unit vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/AnalysisUnit/2.0?languageVersion=en-2.0_de-2.0.1_fr-2.0.1_it-2.1.1_nl-2.1.1' \
     -H 'accept: application/xml' > AnalysisUnit.rdf
rapper AnalysisUnit.rdf --output turtle > AnalysisUnit.ttl
curl -I -X POST -H Content-Type:text/turtle -T AnalysisUnit.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/AnalysisUnit

# Time method
echo "Getting time method vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/TimeMethod/1.2?languageVersion=en-1.2_de-1.2.1_fr-1.2.1_nl-1.2.1_it-1.2.1' \
     -H 'accept: application/xml' > TimeMethod.rdf
rapper TimeMethod.rdf --output turtle > TimeMethod.ttl
curl -I -X POST -H Content-Type:text/turtle -T TimeMethod.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/TimeMethod

# Sampling Procedure
echo "getting sampling procedure vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/SamplingProcedure/1.1?languageVersion=en-1.1_de-1.1.1_fr-1.1.3_it-1.1.1_nl-1.1.1' \
     -H 'accept: application/xml' > SamplingProcedure.rdf
rapper SamplingProcedure.rdf --output turtle > SamplingProcedure.ttl
curl -I -X POST -H Content-Type:text/turtle -T SamplingProcedure.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/SamplingProcedure

# Type of Instrument
echo "getting type of instrument vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/TypeOfInstrument/1.1?languageVersion=en-1.1_nl-1.1.1_de-1.1.1_fr-1.1.1_it-1.1.1' \
     -H 'accept: application/xml' > TypeOfInstrument.rdf
rapper TypeOfInstrument.rdf --output turtle > TypeOfInstrument.ttl
curl -I -X POST -H Content-Type:text/turtle -T TypeOfInstrument.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/TypeOfInstrument

# Data Source Type
echo "getting data source type vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/DataSourceType/1.0?languageVersion=en-1.0_de-1.0.1_nl-1.0.1_fr-1.0.1_it-1.0.1' \
     -H 'accept: application/xml' > DataSourceType.rdf
rapper DataSourceType.rdf --output turtle > DataSourceType.ttl
curl -I -X POST -H Content-Type:text/turtle -T DataSourceType.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/DataSourceType

 # Summary statistics
 echo "getting summary statistics vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/SummaryStatisticType/2.1?languageVersion=en-2.1_nl-2.1.1_de-2.1.1_fr-2.1.1_it-2.1.1' \
     -H 'accept: application/xml' > SummaryStatistics.rdf
rapper SummaryStatistics.rdf --output turtle > SummaryStatistics.ttl
curl -I -X POST -H Content-Type:text/turtle -T SummaryStatistics.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/SummaryStatistics

# Mode of Collection
echo "getting mode of collection vocab"
curl -X 'GET' \
     'https://vocabularies.cessda.eu/v2/vocabularies/ModeOfCollection/4.0?languageVersion=en-4.0_nl-4.0.1_de-4.0.1_fr-4.0.1_it-4.0.1' \
     -H 'accept: application/xml' > ModeOfCollection.rdf
rapper ModeOfCollection.rdf --output turtle > ModeOfCollection.ttl
curl -I -X POST -H Content-Type:text/turtle -T ModeOfCollection.ttl -G https://fuseki.experimental.odissei.nl/skosmos/data --data-urlencode graph=https://vocabularies.cessda.eu/vocabulary/ModeOfCollection

echo "Checking search index..."
curl "https://skosmos.odissei.nl/rest/v1/search?vocab=stw&query=a*"

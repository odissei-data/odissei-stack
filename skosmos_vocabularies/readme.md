# SKOSMOS, Fuseki and friends

Skosmos is the application responsible for hosting and parsing the SKOS vocabularies which are loaded inside it. These vocabularies exist inside the Fuseki database, which is a graph database. There's also a container for speeding up loading times, which is the Varnish memcache container.

Whenever the container reboots (considering the volume isn't persistent), the vocabularies are lost and must be reloaded. This is handled through a bit of script.

## The init script explained

The Fuseki instance only accepts turtle-formatted files being posted. As a result - the following things happen:

1. The file is downloaded by the vendor.
2. It's converted by the Raptor command line utility (using `rapper`).
3. It's then uploaded into Fuseki using a `curl` command.

## Skosmos config and relation with the init script

The Skosmos config which is mounted as the container is rebooted, provides mappings which are required for it to locate vocabularies inside Fuseki. This configuration has a couple of relevant factors:

1. The SparQL directive is where Skosmos will look for a corresponding vocabulary file.
2. The languages determine what languages will be available in the interface of Skosmos for a given vocabulary file.

The init script is responsible for putting files in the correct location inside Fuseki. It's imperative the SparQL directive matches with this location; Fuseki has a nasty habit of saying "oh it's worked!" after uploading, when nothing is visible. This means your file is there, but Skosmos won't be able to find it.

# Loading a vocabulary into Fuseki

1. `cat odissei-init.sh`
2. Execute the corresponding line for the dict you want to load.

## Loading the CBS dictionary

1. `cat odissei-init.sh`
2. Copy corresponding line and just execute that one. The vocabulary file is expected to be in the same folder as the curl command, so you have to get it there using scp or something comparable.

Just for reference:

1. Find the file on your own computer in a terminal window.
2. scp `<filename> <username>@dev.odissei.nl/data/volume_2/odissei-stack`

# Loading all vocabularies into Fuseki

1. `odissei-init.sh`

# Resetting SKOSMOS & Fuseki

1. `./stop-prod.sh`
2. `./stop-prod.sh`
3. `cd skosmos_vocabularies`
4. `./odissei-init.sh`

Fuseki and Skosmos are up relatively quickly.

# Validating vocabularies are there.

1. go to skosmos.dev.odissei.nl
2. Open a dictionary. Check if you see terms. If not - reupload that dict or re-execute that part of the curl after fixes.

# Debugging

Common things that go wrong are here.

## Vocabulary doesn't load

Check if the curl URL properly matches the SparQL endpoint described in the config. If this doesn't match - Fuseki does pick it up, but Skosmos can't access it properly.

## Skosmos doesn't start

Go through the configuration file line by line, and inspect logging using `docker logs skosmos` to see what's happening.

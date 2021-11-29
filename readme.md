# ODISSEI Stack
This repository aims at providing, for hosting Dataverse, both of a local dev stack and a SSL enabled production stack with FQDN. 

Both of the stacks have 2 parts:
 * yaml file for proxy
 * and yaml file for other services

The purpose of splitting the proxy part from the rest of the services is to keep the services decoupled so each of them 
can be safely restarted without disrupt the rest. Restart the proxy will cut the connectivity, however, restarting the 
proxy would take 1 or 2 seconds only, so the downtime is manageable.

One other purpose of using proxy is to provide secured connectivity to other ODISSEI related services. The proxy will 
not only handle SSL certificate but also handle multi subdomain scenario. While 
there are more services

### Building dev stack
This stack is meant to be used mainly as the dev stack on local host. 
It can be run on any remote server as well, i.e for demo purpose, when `HOSTNAME` in associated `env` file is 
properly set. 
#### Step 1: Start the proxy
 `docker-compose-no-ssl.env`
```shell
docker-compose -f docker-compose-no-ssl-proxy.yaml up -d
```

#### Step 2: Start the services
```shell
docker-compose -f docker-compose-no-ssl-services.yaml up -d
```
As specified in the `docker-compose-no-ssl.env`, if you visit `http://dev.localhost` on your local machine now, you will 
see the dataverse instance. 

 * `solr.dev.localhost` will take you to the solr page
 * `dbgui.dev.localhost` will take you to the db admin page
 * `dev.localhost:8085` will take you to the demo contact page for CBS

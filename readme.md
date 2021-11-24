# ODISSEI Stack
This repository aims at providing
 * a dev stack 
 * and a production stack

for hosting ODISSEI Davaverse instances. 

The both of the stack consists of 2 parts:
 * yaml file for proxy
 * and yaml file for other services

The purpose of splitting the proxy part from the rest of the services is to keep the services decoupled so each of them 
can be safely restared without hurting the rest. Restart the proxy will cut the connectivity, however, restarting the 
proxy would take 1 or 2 seconds only, so the downtime is manageable.

One other purpose of using proxy is to provide secured connectivity to other ODISSEI related services. The proxy will 
not only handle SSL certificate but also handle multi subdomain scenario. While 
there are more services

### Building dev stack
This stack is meant to be used as the dev stack on local host
If you want to run it on remote server, please chnage the `HOSTNAME` in
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

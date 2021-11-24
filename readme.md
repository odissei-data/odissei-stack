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

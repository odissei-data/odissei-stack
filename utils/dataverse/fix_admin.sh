#!/usr/bin/env sh
#
# This script takes care to give superuser credentials to the admin user.

docker exec -it postgres psql -U dataverse -c "UPDATE authenticateduser SET superuser = 't' WHERE id = 1"

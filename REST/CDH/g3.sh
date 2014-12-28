#!/bin/bash

curl -X POST -H "Content-Type:application/json" -u admin:admin \
  -d '{ "hostNames" : [ "h147" ], "sshPort" : 22, "userName" : "root", "password" : "root1234" }' \
  'http://localhost:7180/api/v7/cm/commands/hostInstall'



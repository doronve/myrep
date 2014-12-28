#!/bin/bash

curl -X POST -H "Content-Type:application/json" -u admin:admin \
  -d '{ "items": [ { "name": "my_hbase", "type": "HBASE" } ] }' \
  'http://localhost:7180/api/v1/clusters/Cluster_175/services'

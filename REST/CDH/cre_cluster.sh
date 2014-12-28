#!/bin/bash

curl -X POST -u "admin:admin" -i \
  -H "content-type:application/json" \
  -d '{ "items": [
          {
            "name": "test",
            "version": "CDH4"
          }
      ] }'  \
  http://h190:7180/api/v8/clusters

#!/bin/bash

#curl -u admin:admin 'http://localhost:7180/api/v7/clusters'

#curl -u admin:admin  'http://localhost:7180/api/v7/clusters/Cluster_175/services'

#curl -u admin:admin  'http://localhost:7180/api/v7/clusters/Cluster_175/services/hdfs/config'
#curl -u admin:admin  'http://localhost:7180/api/v1/clusters/Cluster_175/services/hdfs/config'


#curl -u admin:admin  'http://localhost:7180/api/v7/clusters/Cluster_175/hosts'
#curl -u admin:admin  'http://localhost:7180/api/v7/clusters/Cluster_175/hosts/ec66e266-7814-4c03-a395-66a168bf70d1'

#curl -u admin:admin  'http://localhost:7180/api/v7/hosts'
#curl -u admin:admin  'http://localhost:7180/api/v7/hosts/79f603e4-1df0-432e-b32b-5a4e68722269'
#curl -X DELETE -u admin:admin  'http://localhost:7180/api/v7/hosts/79f603e4-1df0-432e-b32b-5a4e68722269'
#curl -X DELETE -u admin:admin  'http://localhost:7180/api/v7/hosts/7e16eb87-0074-4a4a-b813-94b350c65265'

curl -X GET -u admin:admin  'http://localhost:7180/api/v7/cm/allHosts/config?view=summary'

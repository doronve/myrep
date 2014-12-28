#!/bin/bash
################################################################################
#                                                                              #
# Name: get_cluster_name.sh                                                    #
# Description: get the Cluster(s) Name(s)                                      #
# Arguments:                                                                   #
#          - host name                                                         #
# Assumptions:                                                                 #
#          - admin user/pass are default                                       #
#          - providing no host will result in default host name "h162"         #
#          - Other scripts are located in the same directory                   #
# Using Script:                                                                #
#          - get_version.sh                                                    #
#                                                                              #
#                                                                              #
################################################################################

MYDIR=`dirname $0`
host=$1
[[ -z "$host" ]] && host=h162

apiver=`$MYDIR/get_version.sh $host`

curl -u admin:admin "http://$host:7180/api/$apiver/clusters" 2> /dev/null | awk '/name/{print $NF}'|sed 's/,//' | sed 's/"//g'


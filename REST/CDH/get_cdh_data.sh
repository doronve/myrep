#!/bin/bash
################################################################################
#                                                                              #
# Arguments: host name                                                         #
# Assumptions:                                                                 #
#          - admin user/pass are default                                       #
#          - providing no host will result in default host name "h162"         #
#                                                                              #
# get_version       - get the CDH REST APIs version                            #
# get_cluster_name  - Description: get the Cluster(s) Name(s)                  #
# get_cluster_hosts - Description: get the list of hosts in the cluster        #
#                                                                              #
#                                                                              #
################################################################################

export host=$1
[[ -z "$host" ]] && host=h162
export func=$2
[[ -z "$func" ]] && func=get_version

#
# get_version 
#
function get_version {
  curl -u admin:admin "http://$host:7180/api/version" 2> /dev/null
}

export apiver=`get_version`
#
# get_cluster_name 
#
function get_cluster_name {
  curl -u admin:admin "http://$host:7180/api/$apiver/clusters" 2> /dev/null | awk '/name/{print $NF}'|sed 's/,//' | sed 's/"//g'
}


#
# get_cluster_hosts
#
function get_cluster_hosts {
  for name in `get_cluster_name`
  do
    echo $name
    for hostid in `curl -u admin:admin "http://$host:7180/api/$apiver/clusters/$name/hosts" 2>/dev/null | awk '/hostId/{print $NF}'|sed 's/"//g'`
    do
      curl -u admin:admin "http://$host:7180/api/$apiver/hosts/$hostid" 2>/dev/null | awk '/hostname/{print $NF}'|sed 's/"//g'|sed 's/,//'
    done | sort
  done
}

$func

#!/bin/bash
################################################################################
#                                                                              #
# Name: get_cluster_hosts.sh                                                   #
# Description: get the list of hosts in the cluster                            #
# Arguments:                                                                   #
#          - host name                                                         #
# Assumptions:                                                                 #
#          - admin user/pass are default                                       #
#          - providing no host will result in default host name "h162"         #
#          - All requried scripts are located in the same directory            #
#                                                                              #
#                                                                              #
################################################################################

host=$1
[[ -z "$host" ]] && host=h162

MYDIR=`dirname $0`

apiver=`$MYDIR/get_version.sh $host`

for name in `$MYDIR/get_cluster_name.sh $host`
do
  echo $name
  for hostid in `curl -u admin:admin "http://$host:7180/api/$apiver/clusters/$name/hosts" 2>/dev/null | awk '/hostId/{print $NF}'|sed 's/"//g'`
  do
    curl -u admin:admin "http://$host:7180/api/$apiver/hosts/$hostid" 2>/dev/null | awk '/hostname/{print $NF}'|sed 's/"//g'|sed 's/,//'
  done | sort
done



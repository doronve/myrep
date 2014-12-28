#!/bin/bash
################################################################################
#                                                                              #
# Name: get_version.sh                                                         #
# Description: get the CDH REST APIs version                                   #
# Arguments:                                                                   #
#          - host name                                                         #
# Assumptions:                                                                 #
#          - admin user/pass are default                                       #
#          - providing no host will result in default host name "h162"         #
#                                                                              #
#                                                                              #
################################################################################

host=$1
[[ -z "$host" ]] && host=h162

curl -u admin:admin "http://$host:7180/api/version" 2> /dev/null


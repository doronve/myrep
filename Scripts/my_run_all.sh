#!/bin/bash
################################################################################
#                                                                              #
# Name: my_run_all.sh                                                          #
# Description: Run a command on multiple remote hosts                          #
#              Similar to Project C3 (http://www.csm.ornl.gov/torc/c3/)        #
#                                                                              #
# Input paramaters: Command (can be with multiple arguments)                   #
#                                                                              #
# Hard coded requirements:                                                     #
#              - all nodes should be accessible via password-less ssh          #
#              - a 'nodelist.lst' file with list of hosts - host per line      #
#                Nodes can be excluded using # as first char in line           #
#              - Local directory writeable for Logs                            #
#                output files in convention of log_$hostname                   #
#                suffix out for stdout and err for stderr                      #
#                                                                              #
# Flow:                                                                        #
#     - if no command provided - use 'hostname' as command                     #
#     - loop on all hosts in nodelist file and execute command in background   #
#     - wait for all commands to finish                                        #
#     - show log files location                                                #
#                                                                              #
################################################################################

MYDIR=`dirname $0`
nodelist=$MYDIR/nodelist.lst
logdir=$MYDIR/Logs
mkdir -p $logdir

command=$*
[ x"$command" = "x" ] && command=hostname

echo command=$command

for host in `grep -v ^# $nodelist`
do
  nohup ssh $host "$command" > ${logdir}/log_$host.out 2> ${logdir}/log_$host.err &
done

wait 

ls -lrt ${logdir}/log_*

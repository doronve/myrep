#!/usr/bin/python


import urllib2
import sys, getopt
import base64
from urlparse import urlparse
import json
from pprint import pprint
import cdhRest


oozie_json = '{ "items" : [ { "name" : "oozie_config_safety_valve", "value" : "<property><name>oozie.action.sharelib.for.java</name><value>java</value></property><property><name>oozie.service.ELService.ext.functions.workflow</name><value>bdaHadoopCounter=com.amdocs.bda.oozie.CountersElFunctions#bdaHadoopCounter</value></property>" }, { "name" : "oozie_executor_extension_classes", "value" : "org.apache.oozie.action.hadoop.HiveActionExecutor,org.apache.oozie.action.hadoop.SqoopActionExecutor,org.apache.oozie.action.email.EmailActionExecutor,org.apache.oozie.action.hadoop.ShellActionExecutor,org.apache.oozie.action.hadoop.DistcpActionExecutor,org.apache.oozie.action.hadoop.Hive2ActionExecutor,com.amdocs.bda.oozie.actions.WaitAction" }, { "name" : "oozie_java_heapsize", "value" : "1073741824" }, { "name" : "oozie_workflow_extension_schemas", "value" : "hive-action-0.2.xsd,sqoop-action-0.2.xsd,email-action-0.1.xsd,distcp-action-0.1.xsd,shell-action-0.1.xsd,ssh-action-0.1.xsd,distcp-action-0.2.xsd,hive-action-0.3.xsd,hive-action-0.4.xsd,hive-action-0.5.xsd,oozie-sla-0.1.xsd,oozie-sla-0.2.xsd,sqoop-action-0.3.xsd,sqoop-action-0.4.xsd,shell-action-0.2.xsd,shell-action-0.3.xsd,ssh-action-0.2.xsd,hive2-action-0.1.xsd,wait-action-0.5.xsd" } ] }'

content_header = {'Content-type':'application/json',
                 'Accept':'application/vnd.error+json,application/json',
                 'Accept-Version':'1.0'}
oozieJsonObj = json.loads(oozie_json)


def main(argv):
   chost = ''
   username = ''
   password = ''
   try:
      opts, args = getopt.getopt(argv,"h:u:p:",["chost=","user=","pass="])
   except getopt.GetoptError:
      print 'test.py -h <chost> -u <username> -p <password>'
      sys.exit(2)
   for opt, arg in opts:
      if opt in ("-h", "--chost"):
         chost = arg
      elif opt in ("-u", "--user"):
         username = arg
      elif opt in ("-p", "--pass"):
         password = arg
   if __debug__: print 'host is:', chost
   if __debug__: print 'username is:', username
   if __debug__: print 'password is:', password

   base64string = base64.encodestring( '%s:%s' % (username, password))[:-1]
   authheader =  'Basic %s' % base64string
   apiver = cdhRest.getversion(chost, authheader)
   baseurl = "http://" + chost + ":7180/api/" + apiver + "/clusters"
   clusterslist = cdhRest.get_cluster_names(baseurl, authheader)
   for cluster in clusterslist:
      baseurl1 = baseurl + "/" + cluster + "/services"
      service = cdhRest.get_service_name_by_type(baseurl1, "OOZIE", authheader)
      baseurl1 = baseurl1 + "/" + service + "/roleConfigGroups"
      confgroups = cdhRest.get_conf_groups(baseurl1, "OOZIE_SERVER",  authheader)
      for confgroup in confgroups:
        baseurl2 = baseurl1 + "/" + confgroup + "/config?view=full"
        req = urllib2.Request(baseurl2)
        req.add_header("Authorization", authheader)
        handle = urllib2.urlopen(req)
        thepage = handle.read()
        data = json.loads(thepage)
        #if __debug__: pprint(data)
# example taken from here http://stackoverflow.com/questions/21243834/doing-put-using-python-urllib2
        baseURL = baseurl1 + "/" + confgroup + "/config"
        if __debug__: print "baseURL = ", baseURL
        request = urllib2.Request(url=baseURL, data=json.dumps(oozieJsonObj), headers=content_header)
        if __debug__: print "request = ", request
        request.add_header("Authorization", authheader)
        if __debug__: print "request = ", request
        request.get_method = lambda: 'PUT' #if I remove this line then the POST works fine.
        if __debug__: print "request = ", request

        response = urllib2.urlopen(request)

        if __debug__: print response.read()


if __name__ == "__main__":
   main(sys.argv[1:])

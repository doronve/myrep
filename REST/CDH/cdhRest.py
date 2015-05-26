#!/usr/bin/python


import urllib2
import sys, getopt
import base64
from urlparse import urlparse
import json
from pprint import pprint


#
# function get version - get the REST api version of cm
#
def getversion(chost, authheader):
   if __debug__: print "in getversion. chost = " , chost, "authheader = ", authheader
   theurl = "http://" + chost + ":7180/api/version"
   req = urllib2.Request(theurl)
   req.add_header("Authorization", authheader)
   handle = urllib2.urlopen(req)
   ret = handle.read()
   if __debug__: print "return ", ret
   return ret

#
# get_cluster_names - get list of cluster names
#
def get_cluster_names(theurl, authheader):
   if __debug__: print "in get_cluster_names theurl= ", theurl, "authheader= ", authheader
   req = urllib2.Request(theurl)
   req.add_header("Authorization", authheader)
   handle = urllib2.urlopen(req)
   thepage = handle.read()
   data = json.loads(thepage)
   ret = []
   for xx in data["items"]:
     ret = ret + [xx["name"]]
   if __debug__: print "return ", ret
   return ret

#
# get_service_name_by_type - get service name by type
#
def get_service_name_by_type(theurl, type, authheader):
   if __debug__: print "in get_service_name_by_type theurl= ", theurl, "type= ", type, "authheader= ", authheader
   req = urllib2.Request(theurl)
   req.add_header("Authorization", authheader)
   handle = urllib2.urlopen(req)
   thepage = handle.read()
   data = json.loads(thepage)
   for xx in data["items"]:
     aa = xx["type"]
     if (aa == type):
       ret = xx["name"]
       if __debug__: print "return ", ret
       return ret

#
# get_conf_groups - get list of configuration groups
#
def get_conf_groups(theurl, roleType, authheader):
   if __debug__: print "in get_conf_groups theurl= ", theurl, "authheader= ", authheader
   req = urllib2.Request(theurl)
   req.add_header("Authorization", authheader)
   handle = urllib2.urlopen(req)
   thepage = handle.read()
   data = json.loads(thepage)
   ret = []
   for xx in data["items"]:
     if (xx["roleType"] == roleType):
        ret = ret + [xx["name"]]
   if __debug__: print "return ", ret
   return ret

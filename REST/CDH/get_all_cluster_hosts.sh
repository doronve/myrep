#!/bin/bash

myhomefile=/var/www/html/myhome.html
mv $myhomefile ${myhomefile}.`date +%Y%m%d_%H%M%S`

cat  /netapp_nfs/Hadoop/REST/myhome1.html > $myhomefile
for cmhost in `grep -v ^# /netapp_nfs/Hadoop/REST/CM_Hosts.lst`
do
  echo "<tr>" >> $myhomefile
  echo "<th>Cluster $cmhost</th>" >> $myhomefile
  echo "<td>" >> $myhomefile
  for host in `/netapp_nfs/Hadoop/REST/get_cluster_hosts.sh $cmhost`
  do
    echo "$host <br>" >> $myhomefile
  done
  echo "</td>" >> $myhomefile
  echo "<td><a href=\"http://${cmhost}:7180\"  target=\"_blank\"><IMG SRC=\"http://10.232.83.21/myhome/images/cloudera-small.png\" >${cmhost}</a></td>" >> $myhomefile
  echo "</tr>" >> $myhomefile
done

echo "
<table border=\"1\" cellpadding=\"1\">
<caption>Various Statistics</caption>
<tr>
<th>Stat</th>
<th>Value</th>
</tr>
<tr>
<th>NMap<br/>Ping scan</td>
<td>`cat /var/www/html/latest_nmap_ping.nmap.tail-1`</td>
</tr>
<tr>
<th>NMap Ping<br/>Previous Day<br/>Difference</td>
<td>`sed 's/$/<br>/'  /var/www/html/latest_nmap_ping.gnmap.diff`</td>
</tr>
</table>
</CENTER>

</body>
</html>
" >> $myhomefile

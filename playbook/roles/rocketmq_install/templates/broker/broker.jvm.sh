#!/bin/bash
#set -x
#this script is only going to set Rocketmq Broker server's jvm

RQ_HOME_BIN=/opt/rocketmq/bin

#RQ_HOME_BIN=/home/dc-user/rq/rocketmq-all-4.3.2-bin-release/bin
#$RQ_HOME_BIN/runserver.sh to modify the #39  JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -Xmn2g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"
#$RQ_HOME_BIN/runbroker.sh to modify the #39   JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g -Xmn4g"
#get current physical memory setting

mem_size=`free -m | grep Mem | awk '{print $2}'`

#set jetty JVM xmx to 50% of mem

jmem=$(($mem_size/2))
jmemn=$(($jmem/2))
jmem=$jmem"m"
jmemn=$jmemn"m"

#sed -i "s/-Xmn[0-9]\+[g|m]/-Xmn$jmemn/g" $RQ_HOME_BIN/runserver.sh
#sed -i "s/-Xms[0-9]\+[g|m]/-Xms$jmem/g" $RQ_HOME_BIN/runserver.sh
#sed -i "s/-Xmx[0-9]\+[g|m]/-Xmx$jmem/g" $RQ_HOME_BIN/runserver.sh

sed -i "s/-Xmn[0-9]\+[g|m]/-Xmn$jmemn/g" $RQ_HOME_BIN/runbroker.sh
sed -i "s/-Xms[0-9]\+[g|m]/-Xms$jmem/g" $RQ_HOME_BIN/runbroker.sh
sed -i "s/-Xmx[0-9]\+[g|m]/-Xmx$jmem/g" $RQ_HOME_BIN/runbroker.sh

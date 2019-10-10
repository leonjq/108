#!/usr/bin/env bash
#
# rocketmq - this script starts and stops the rocketmq daemon
#
# chkconfig:   - 85 15

ROCKETMQ_HOME=/opt/rocketmq
ROCKETMQ_BIN=${ROCKETMQ_HOME}/bin
LOG_DIR=${ROCKETMQ_HOME}/logs
BROKER_LOG=${LOG_DIR}/broker.log

#BROKER_CONF=/opt/rocketmq/conf/2m-2s-async/broker-a.properties
#BROKER_CONF=/opt/rocketmq/conf/2m-2s-async/broker-a-s.properties
#BROKER_CONF=/opt/rocketmq/conf/2m-2s-async/broker-b.properties
#BROKER_CONF=/opt/rocketmq/conf/2m-2s-async/broker-b-s.properties

start() {
    if [ ! -d ${LOG_DIR} ];then
       su - rocketmq -c "mkdir ${LOG_DIR}"
    fi
    su - rocketmq -c  "nohup  sh $ROCKETMQ_HOME/bin/mqbroker -c ${BROKER_CONF} > ${BROKER_LOG} 2>&1 &"
    echo  "The broker[%s, ${ADDR}] boot success..."
}
stop() {
    cd ${ROCKETMQ_HOME}
    su - rocketmq -c "sh $ROCKETMQ_HOME/bin/mqshutdown broker"
    sleep 1
    su - rocketmq -c "sh $ROCKETMQ_HOME/bin/mqshutdown namesrv"
}
restart() {
    stop
    sleep 5
    start
}
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart}"
        exit 2
esac

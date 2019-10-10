#!/usr/bin/env bash
#
# rocketmq - this script starts and stops the rocketmq daemon
#
# chkconfig:   - 85 15
ROCKETMQ_HOME=/opt/rocketmq
ROCKETMQ_BIN=${ROCKETMQ_HOME}/bin
ADDR=`hostname -i`:9876
LOG_DIR=${ROCKETMQ_HOME}/logs
NAMESERVER_LOG=${LOG_DIR}/namesrv.log
BROKER_LOG=${LOG_DIR}/broker.log
start() {
    if [ ! -d ${LOG_DIR} ];then
       su - rocketmq -c "mkdir ${LOG_DIR}"
    fi
	
    cd ${ROCKETMQ_HOME}
    su - rocketmq -c  "nohup sh $ROCKETMQ_HOME/bin/mqnamesrv > ${NAMESERVER_LOG} 2>&1 &"
    echo  "The Name Server boot success..."
   # su - rocketmq -c  "nohup  sh $ROCKETMQ_HOME/bin/mqbroker -n ${ADDR} > ${BROKER_LOG} 2>&1 &" 
   # echo  "The broker[%s, ${ADDR}] boot success..."
}
stop() {
    cd ${ROCKETMQ_HOME}
   # su - rocketmq -c "sh $ROCKETMQ_HOME/bin/mqshutdown broker"
   # sleep 1
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
